


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gami/Screens/ProfileScreen.dart';
import 'package:gami/Screens/ShareScreen.dart';
import 'package:gami/Screens/TimerScreen.dart';
import 'package:gami/Global/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/Constant.dart';

import '../Global/Global.dart';

import 'package:adcolony/adcolony.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:gami/Screens/progress_dialog.dart';
import 'package:gami/Constant/Constant.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:gami/Screens/NewsPost_Details.dart';
import 'package:package_info/package_info.dart';
import 'package:gami/Screens/CheckVersion.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'package:gami/Screens/Transactions.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:intl/intl.dart';


List<Map<String, dynamic>> arrNewsPosts = [];

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

bool isAnimated = false;

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin {

  TabController tabController;
  int selectedIndex = 0;
  double heightWatchEarn = 300;

  double whiteBlueTextLeftPadding = 0;

  ScrollController controller;

  double widthBGFull = 0;
  double heightBGFull = 0;

  double zoomScale = 1;

  final zones = [
    'vz89473daa443d40f485',
    'vz89473daa443d40f485',
    'vz89473daa443d40f485'
  ];

  ProgressDialog progressDialog;
  bool isInterstitialAdLoaded = false;
  bool isRewardedAdLoaded = false;
  bool isRewardedVideoComplete = false;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;
  ScrollController controllerFirst;

  bool isFacebook = false;
  // bool isAddColony = false;
  String strAdvertTypeToShow = '0';

  Map<String, dynamic> dictUserDetails = {};
  List<Map<String, dynamic>> arrInvitedList = [];

  String strIsAdverts = '0';

  var first = 0;
  var strUserName = "";

  String strAdsType = '';

  var dictAdsCount = {
    'first':'0',
    'dayAdsCount': '0',
    'hour': '0',
    'day': '0'
  };

/*

InterstitialAd _interstitialAd;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,);
  */

  Widget currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  checkAdsCount() async {
    final now = DateTime.now();
    final sharedPref = await SharedPreferences.getInstance();

    final strAdsCount = (sharedPref.getString('adsCount') ?? '');

    dictAdsCount = strAdsCount.isEmpty
        ? dictAdsCount
        : Map<String, String>.of(jsonDecode(strAdsCount));

    print('strTimestrTimestrTimestrTimestrTimestrTimestrTime');
    print(dictAdsCount['day']);
    print(dictAdsCount['hour']);

    if (now.hour.toString() != dictAdsCount['hour']) {
      dictAdsCount['hour'] = now.hour.toString();

      dictAdsCount['first'] = '0';
    }

    if (now.day.toString() != dictAdsCount['day']) {
      dictAdsCount['day'] = now.day.toString();
      dictAdsCount['hour'] = '0';

      dictAdsCount['first'] = '0';
    }

    sharedPref.setString('adsCount', jsonEncode(dictAdsCount));
  }

  String strTotal = '0';
  String strMaxAdvertsInDay = '5';
  String strMaxAdvertsInHour = '20';
  
  getGlobalSettingForTabbar() async {
    final snapShot = await FirebaseFirestore.instance.collection(tblGlobalSettings).get();
    final arrGlobalSettings = snapShot.docs.map((doc) => doc.data()).toList();
    
    strMaxAdvertsInDay = arrGlobalSettings[0]['maxAdvertsInDay'].toString();
    strMaxAdvertsInHour = arrGlobalSettings[0]['maxAdvertsInHour'].toString();
    
    setState(() {
      
    });
  }

  getTransactionList() async {
    strTotal = '0';

    final querySnapShot = await FirebaseFirestore.instance
        .collection(tblTransactions)
        .doc(strInvitationCode)
        .collection(strInvitationCode).get();

    final arrTransactions = querySnapShot.docs.map((docInMapFormat) {
      return docInMapFormat.data();
    }).toList();

    for (final dict in arrTransactions) {
      final strAttention = int.parse(dict['attention'].toString());
      final strInvite = int.parse(dict['invite'].toString());
      final strMining = int.parse(dict['mining'].toString());

      strTotal = (int.parse(strTotal)+strAttention+strInvite+strMining).toString();
    }

    setState(() {

    });

    Future.delayed(Duration(milliseconds: 40), () {
      getGlobalSettingForTabbar();
    });
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Admob.initialize();
    super.initState();

    DartNotificationCenter.subscribe(
      channel: tblTransactions,
      observer: '0',
      onNotification: (result) => getTransactionList(),
    );

    AdColony.init(AdColonyOptions('app8e401cbe7abd4efb9c', '0', this.zones));

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
      },
    );

    interstitialAd.load();
    rewardAd.load();

    FacebookAudienceNetwork.init(
      testingId: "35e92a63-8102-46a4-b0f5-4fd269e6a13c",
    );

    _loadInterstitialAd();
    _loadRewardedVideoAd();
    controller = ScrollController();
    controllerFirst = ScrollController();

    Future.delayed(Duration(microseconds:60),() {
      getUserData();
      checkAdsCount();

      if (arrNewsPosts.length == 0) {
        getNewsPosts(context);
      }

      widthBGFull = MediaQuery.of(context).size.width;
      heightBGFull = MediaQuery.of(context).size.height;
    });

    Future.delayed(Duration(seconds:1),() {
      homeShowAnimation();
      checkVersion();

      controller.animateTo(250,
          curve: Curves.linear, duration: Duration(seconds:1)
      );

      setState(() {

      });
    });

    Future.delayed(Duration(seconds:1),() {
      getTransactionList();
    });

  }

  checkVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {

      Future.delayed(Duration(seconds:1),() {
        final arrMinVersion = dictAppDetails['minVersion'].toString().split('.');
        final arrPackageInfoVersion = packageInfo.version.toString().split('.');

        if (int.parse(arrMinVersion[0]) > int.parse(arrPackageInfoVersion[0])) {
          if (dictAppDetails['minVersion'].toString() != packageInfo.version) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                CheckVersion()), (Route<dynamic> route) => false);
          }
        } else if (int.parse(arrMinVersion[1]) > int.parse(arrPackageInfoVersion[1])) {
          if (dictAppDetails['minVersion'].toString() != packageInfo.version) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                CheckVersion()), (Route<dynamic> route) => false);
          }
        } else if (int.parse(arrMinVersion[2]) > int.parse(arrPackageInfoVersion[2])) {
          if (dictAppDetails['minVersion'].toString() != packageInfo.version) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                CheckVersion()), (Route<dynamic> route) => false);
          }
        }
      });
    });
  }

  listener(AdColonyAdListener event) {
    if (event == AdColonyAdListener.onRequestFilled) AdColony.show().then((value) {

    }).catchError((error) {
      showError(context, error.message.toString());
    });
    progressDialog.dismiss();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#1192856601187343_1192857274520609",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "IMG_16_9_APP_INSTALL#1192856601187343_1192857274520609",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
          isRewardedVideoComplete = true;
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            value["invalidated"] == true) {
          isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }

  // _showInterstitialAd() {
  //   if (isInterstitialAdLoaded == true)
  //     FacebookInterstitialAd.showInterstitialAd();
  //   else
  //     print("Interstial Ad not yet loaded!");
  // }

  homeShowAnimation() {
    Future.delayed(Duration(microseconds:5),() {
      whiteBlueTextLeftPadding = (MediaQuery.of(context).size.width/2)-(MediaQuery.of(context).size.width-(80*2))/2;
      
      if (!isAnimated) {
        sizeWatchEarnText = 20;

        Future.delayed(Duration(seconds:1),() {
          isAnimated = true;

          setState(() {

          });
        });
      }

      heightWatchEarn = 10;

      setState(() {

      });
    });

    Future.delayed(Duration(milliseconds:50),() {
      if (isAnimated) {
        whiteBlueTextLeftPadding = (MediaQuery.of(context).size.width/2)-(MediaQuery.of(context).size.width-(80*2))/2;
      }

      setState(() {

      });

    });
  }

  homeHideAnimation() {
    heightWatchEarn = 400;
    whiteBlueTextLeftPadding = MediaQuery.of(context).size.width;

    setState(() {

    });
  }

  getUserData() {
    try {
      FirebaseFirestore.instance.collection(tblUserDetails)
          .doc(strMobileNumber).get()
          .then((value) {
        dictUserDetails = value.data();

        strInvitationCode = dictUserDetails[kInvitationCode];
        strMobileNumber = dictUserDetails[kMobileNumber];
        this.strUserName = dictUserDetails[kUserName];

        rewardEarnings = (dictUserDetails[kRewardEarnings] == null)
            ? '0'
            : dictUserDetails[kRewardEarnings];

        strIsAdverts = dictUserDetails[kIsAdverts];

        getInvitedList();

        setState(() {

        });
      });
    } catch (error) {
      showError(context, error.message.toString());
    }
  }

  getInvitedList() async {
    final messages = await FirebaseFirestore.instance.collection(tblInvitedList)
        .doc(strInvitationCode)
        .collection(strInvitationCode).get();

    arrInvitedList = messages.docs.map((docInMapFormat) {
      return docInMapFormat.data();
    }).toList();
  }

  updateRewardPoint() {
    var intRewardEarnings = int.parse(rewardEarnings);
    intRewardEarnings += 1;
    try {
      FirebaseFirestore.instance
          .collection(tblUserDetails)
          .doc(strMobileNumber)
          .update({
        kRewardEarnings: intRewardEarnings.toString(),
      }).then((value) {});
    } catch (error) {
      showError(context, error.message.toString());
    }
  }

  getNewsPosts(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile
        || connectivityResult == ConnectivityResult.wifi) {
      try {
        showLoading(context);
        final response = await http.get(Uri.parse(wordPressAPI));
        dismissLoading(context);

        if (response.statusCode == 200) {
          arrNewsPosts = List<Map<String, dynamic>>.from(jsonDecode(response.body));

          setState(() {

          });
        } else {
          throw Exception('Failed to load album');
        }
      } catch (error) {
        dismissLoading(context);
        showError(context, error.toString());
      }
    } else {
      showError(context, 'Check you internet connection.');
    }

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop:() {
        Navigator.pop(context);
        return;
      },
      child:Scaffold(
          backgroundColor:HexColor(kThemeColor),
          body:Stack(
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),// : NeverScrollableScrollPhysics(),
                padding:EdgeInsets.only(
                    bottom:MediaQuery
                        .of(context)
                        .padding
                        .bottom
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                            child:Container(
                                width:MediaQuery.of(context).size.width,
                                height:MediaQuery.of(context).size.height,
                                child:SingleChildScrollView(
                                  scrollDirection:Axis.horizontal,
                                  controller: controller,
                                  physics:NeverScrollableScrollPhysics(),
                                  child:Row(
                                    children: [
                                      Container(
                                        width:1005,
                                        height:MediaQuery.of(context).size.height,
                                        child:
                                        Hero(
                                          tag:'bg',
                                          child:Image.asset(
                                            'assets/images/bgFull.png',
                                            width:MediaQuery.of(context).size.width-(80*2),
                                            height:(MediaQuery.of(context).size.width-(80*2))*1.4,
                                            fit:BoxFit.fill,
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),
                        Positioned(
                            left:0,right:0,top: 0,bottom: 0,
                            child:SafeArea(
                              child:Column(
                                children: [
                                  SizedBox(height:10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 60,
                                      ),
                                      Image.asset(
                                        'assets/images/LOGO.png',
                                        width:MediaQuery.of(context).size.width/5,
                                        fit:BoxFit.fill,
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.only(
                                          right: 30
                                        ),
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          logOut(context);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height:35,),
                                  Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    children: [
                                      //NOTE:
                                      //padding
                                      SizedBox(height:20,),
//NOTE:
                                      //Mascot with animation
                                      //TODO:Azad - change to svg file
                                      Row(
                                        // mainAxisAlignment:MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            child:AnimatedSize(
                                              curve:Curves.fastOutSlowIn,
                                              vsync:this,
                                              duration:Duration(milliseconds:600),
                                              child:Container(
                                                alignment:Alignment.centerRight,
                                                width: whiteBlueTextLeftPadding,
                                                height:(MediaQuery.of(context).size.width-(80*2))*1.4,
                                              ),
                                            ),
                                            visible:isAnimated,
                                          ),
                                          Container(
                                              padding:!isAnimated ?
                                              EdgeInsets.only(
                                                  left: (MediaQuery.of(context).size.width/2)-(MediaQuery.of(context).size.width-(80*2))/2
                                              ) : EdgeInsets.only(
                                                  left:0
                                              ),
                                              child:Hero(
                                                tag:'mascot',
                                                child:Image.asset(
                                                  'assets/images/mascot.png',
                                                  width:MediaQuery.of(context).size.width-(80*2),
                                                  height:(MediaQuery.of(context).size.width-(80*2))*1.4,
                                                  fit:BoxFit.fill,
                                                ),
                                              )
                                          )
                                        ],
                                      ),

                                      //NOTE:
                                      //padding
                                      SizedBox(height:20,),

                                      //NOTE:
                                      //Play button
                                      Visibility(
                                        visible: (selectedIndex == 0) ? true : false,
                                        child:TextButton(
                                          child:Hero(
                                            tag: "registrationPlayButton",
                                            child:SvgPicture.asset(
                                              'assets/images/play.svg',
                                              width:MediaQuery.of(context).size.width/5,
                                              fit:BoxFit.fill,
                                            ),
                                          ), onPressed: () async {

                                            if (strIsAdverts == '0') {
                                              return;
                                            }

                                            final connectivityResult = await (Connectivity().checkConnectivity());
                                              first = int.parse(dictAdsCount['first'].toString());
                                              int dayAdsCount = int.parse(dictAdsCount['dayAdsCount'].toString());
                                              
                                              if (first > int.parse(strMaxAdvertsInHour)
                                                  || dayAdsCount > int.parse(strMaxAdvertsInDay)) {
                                                return;
                                              }

                                              if (connectivityResult == ConnectivityResult.mobile
                                                  || connectivityResult == ConnectivityResult.wifi) {
                                                if (strAdvertTypeToShow == '0') {
                                                  setState(() {
                                                    strAdvertTypeToShow = '1';

                                                    AdColony.request( this.zones[1], listener).then((value) {
                                                      final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());
                                                      getGlobalSettings(context, strInvitationCode, strDate, 'attention');
                                                    }).catchError((error) {
                                                      print(error.message.toString());
                                                    });
                                                  });
                                                } else if (strAdvertTypeToShow == '1') {
                                                  strAdvertTypeToShow = '2';

                                                  setState(() {
                                                    FacebookInterstitialAd.showInterstitialAd().then((value) {
                                                      final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());
                                                      getGlobalSettings(context, strInvitationCode, strDate, 'attention');
                                                    }).catchError((error) {

                                                    });
                                                  });
                                                } else if (strAdvertTypeToShow == '2') {
                                                  strAdvertTypeToShow = '0';

                                                  rewardAd.show();
                                                  final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());
                                                  getGlobalSettings(context, strInvitationCode, strDate, 'attention');
                                                }

                                                dictAdsCount['first'] = (first+1).toString();
                                                dayAdsCount = dayAdsCount+1;
                                                dictAdsCount['dayAdsCount'] = dayAdsCount.toString();

                                                final sharedPref = await SharedPreferences.getInstance();
                                                sharedPref.setString('adsCount', jsonEncode(dictAdsCount));
                                              } else  {
                                                showError(context, 'Check you internet connection.');
                                              }

                                            }

                                        ),
                                      ),
                                      isAnimated
                                          ? AnimatedSize(
                                        curve:Curves.fastOutSlowIn,
                                        vsync:this,
                                        duration:Duration(milliseconds:800),
                                        child:SizedBox(height:heightWatchEarn),
                                      )
                                          :  SizedBox(height:10),

                                      Visibility(
                                        visible:!isAnimated,
                                        child:AnimatedSize(
                                          curve:Curves.fastOutSlowIn,
                                          vsync:this,
                                          duration:Duration(milliseconds:800),
                                          child:Text(
                                            'Watch & Earn',
                                            style:TextStyle(
                                                color:Colors.white,
                                                fontSize: sizeWatchEarnText,
                                                fontFamily:'OpenSans',
                                                fontWeight:FontWeight.w100
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:isAnimated,
                                        child:Text(
                                          'Watch & Earn',
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontSize: sizeWatchEarnText,
                                              fontFamily:'OpenSans',
                                              fontWeight:FontWeight.normal
                                          ),
                                        ),
                                      ),

                                      //NOTE:
                                      //padding
                                      SizedBox(height:40,),

                                      Visibility(
                                          visible:true,
                                          child:Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 30,
                                          )
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                        //SHARE SCREEN
                        ShareScreen(selectedIndex, strInvitationCode),
                        //PROFILE SCREEN
                        ProfileScreen(selectedIndex, strUserName, strMobileNumber, arrInvitedList),
                        //Mining SCREEN
                        //TimerScreen(selectedIndex),
                      ],
                    ),

                    //NOTE: BLOG
                    Visibility(
                      visible:(selectedIndex == 0) ? true : false,
                      child:Column(
                        children: [
                          SizedBox(height:40,),
                          Container(
                            //width:MediaQuery.of(context).size.width,
                            // height:arrNewsPosts.length.toDouble()*300,
                            child:ListView.builder(
                                shrinkWrap: true,
                                physics:NeverScrollableScrollPhysics(),
                                padding:EdgeInsets.only(left:16,right:16,bottom: 40),
                                scrollDirection: Axis.vertical,
                                itemCount:arrNewsPosts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FlatButton(
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      // height:300,
                                      // color: Colors.red,
                                      margin:EdgeInsets.only(bottom:24),
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children:[
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.network(
                                                  getImage(arrNewsPosts[index])
                                              )

                                          ),
                                          SizedBox(height:10,),
                                          Text(
                                            Map<String, dynamic>.from(arrNewsPosts[index]['title'])["rendered"],
                                            style:TextStyle(
                                                color:Colors.white,
                                                fontSize:20,
                                                fontFamily:'OpenSans',
                                                fontWeight:FontWeight.w600
                                            ),
                                          ),
                                          // SizedBox(height:10,),
                                          Html(
                                            data: Map<String, dynamic>.from(arrNewsPosts[index]['excerpt'])["rendered"],
                                            defaultTextStyle: TextStyle(
                                                color:Colors.white,
                                                fontSize:12,
                                                fontFamily:'OpenSans',
                                                fontWeight:FontWeight.normal
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => NewsPostDetails(arrNewsPosts[index])),
                                      );
                                    },
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child:Container(
                    height:MediaQuery
                        .of(context)
                        .padding
                        .bottom+60,
                    padding:EdgeInsets.only(left:30,right:30),
                    decoration: BoxDecoration(
                        color:HexColor(kWPurple).withOpacity(0.17)
                    ),
                    child:Row(
                      children: [
                        Expanded(
                            child:Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedContainer(
                                  // color:Colors.yellow,
                                  // padding:EdgeInsets.only(left:25),
                                  child: navigationBottom(

                                      (selectedIndex == 0)
                                          ? 'assets/images/home-Selected.svg'
                                          : 'assets/images/home.svg',
                                      24,
                                      0
                                  ),
                                  duration: Duration(microseconds: 500),
                                ),
                                AnimatedContainer(
                                  // color:Colors.white,
                                  child: navigationBottom(
                                      (selectedIndex == 1)
                                          ? 'assets/images/share-Selected.svg'
                                          : 'assets/images/share.svg',

                                      24,
                                      1
                                  ),
                                  duration: Duration(microseconds: 500),
                                ),
                                AnimatedContainer(
                                  // color:Colors.yellow,
                                  child: navigationBottom(
                                      (selectedIndex == 2)
                                          ? 'assets/images/profile-Selected.svg'
                                          : 'assets/images/profile.svg',
                                      24,
                                      2
                                  ),
                                  duration: Duration(microseconds: 500),
                                ),
                                AnimatedContainer(
                                  // color:Colors.yellow,
                                  child: navigationBottomTimer(
                                      24,
                                      3
                                  ),
                                  duration: Duration(microseconds: 500),
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child:navigationBottomText(
                                        '\$ ' + strTotal,
                                        0,0
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  )
              ),
            ],
          )
      )
    );
  }

  //NOTE: Menu & Background animation
  navigationBottom(String iconPath, double height, int index) {
    return Container(
      /*height: MediaQuery
          .of(context)
          .padding
          .bottom + 50,*/
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          height: height,
        ),
        onPressed: () {
          selectedIndex = index;

          if (selectedIndex == 0) {
            widthBGFull = MediaQuery.of(context).size.width;
            heightBGFull = MediaQuery.of(context).size.height;
            zoomScale = 1;

            homeShowAnimation();
            controller.animateTo(
                250,
                curve:Curves.linear, duration: Duration(milliseconds: 500)
            );
          } else if (selectedIndex == 1) {
            widthBGFull = MediaQuery.of(context).size.width;
            heightBGFull = MediaQuery.of(context).size.height;
            zoomScale = 1;

            homeHideAnimation();
            controller.animateTo(
                controller.position.maxScrollExtent,
                curve: Curves.linear, duration: Duration(milliseconds: 500)
            );
          }
          else if (selectedIndex == 2) {
            widthBGFull = MediaQuery.of(context).size.width;
            heightBGFull = MediaQuery.of(context).size.height;
            zoomScale = 1;

            homeHideAnimation();
            controller.animateTo(
                400,
                curve: Curves.linear, duration: Duration(milliseconds: 500)
            );
          }
          else if (selectedIndex == 3) {
            widthBGFull = MediaQuery.of(context).size.width;
            heightBGFull = MediaQuery.of(context).size.height;
            zoomScale = 1;

            homeHideAnimation();
            controller.animateTo(
                400,
                curve: Curves.linear, duration: Duration(milliseconds: 500)
            );
          }
          else {
            widthBGFull = MediaQuery.of(context).size.width;
            heightBGFull = MediaQuery.of(context).size.height;
            zoomScale = 1;

            homeHideAnimation();
            controller.animateTo(
                0,
                curve: Curves.linear, duration: Duration(milliseconds: 500)
            );
          }

          setState(() {

          });
        },
      ),
    );
  }

  //NOTE: Menu & Background animation
  navigationBottomTimer(double height, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: IconButton(
        icon: Icon(
          Icons.adjust_rounded,
          color: Colors.white,
          size: 24.0,
          semanticLabel: 'Mining',
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimerScreen()),
          );
        },
      ),
    );
  }

  navigationBottomText(String text, double height, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Transactions()),
          );
        },
      ),
    );
  }

}


