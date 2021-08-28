

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gami/Screens/ProfileScreen.dart';
import 'package:gami/Screens/ShareScreen.dart';
import 'package:gami/Screens/TimerScreen.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';

import '../Global/Global.dart';

import 'package:adcolony/adcolony.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'package:gami/Screens/progress_dialog.dart';
import 'package:gami/Constant/Constant.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:gami/Screens/NewsPost_Details.dart';


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
  bool isAddColony = false;
  Map<String, dynamic> dictUserDetails = {};
  List<Map<String, dynamic>> arrInvitedList = [];

  var first = 0;
  var strUserName = "";


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


  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Admob.initialize();
    super.initState();

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

      // if (arrNewsPosts.length == 0) {
      //   getNewsPosts(context);
      // }

      widthBGFull = MediaQuery.of(context).size.width;
      heightBGFull = MediaQuery.of(context).size.height;
    });

    Future.delayed(Duration(seconds:1),() {
      homeShowAnimation();

      controller.animateTo(250,
          curve: Curves.linear, duration: Duration(milliseconds: 500)
      );

      setState(() {

      });
    });

  }

  listener(AdColonyAdListener event) {
    if (event == AdColonyAdListener.onRequestFilled) AdColony.show().then((value) {

    }).catchError((error) {
      shwoError(context, error.message.toString());
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

        getInvitedList();

        setState(() {

        });
      });
    } catch (error) {
      shwoError(context, error.message.toString());
    }
  }

  getInvitedList() async {
    final messages= await FirebaseFirestore.instance.collection(tblInvitedList)
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
      shwoError(context, error.message.toString());
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
        shwoError(context, error.toString());
      }
    } else {
      shwoError(context, 'Check you internet connection.');
    }

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop:() {
        // Navigator.pop(context);
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
                                  //NOTE:
                                  //NOTE: Logo at the top of the screen
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
                                  //NOTE:
                                  //Middle section with the animation
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
                                          ),

                                            onPressed: () async {
                                              var connectivityResult = await (Connectivity().checkConnectivity());

                                              if (connectivityResult == ConnectivityResult.mobile
                                                  || connectivityResult == ConnectivityResult.wifi) {
                                                if (first == 0) {
                                                  setState(() {
                                                    isAddColony = true;

                                                    AdColony.request( this.zones[1], listener).then((value) {
                                                      updateRewardPoint();
                                                      getUserData();
                                                      first = 1;
                                                    }).catchError((error) {
                                                      print(error.message.toString());
                                                    });
                                                  });
                                                } else if (first == 1) {
                                                  setState(() {
                                                    FacebookInterstitialAd.showInterstitialAd().then((value) {
                                                      updateRewardPoint();
                                                      getUserData();
                                                      first = 2;
                                                    }).catchError((error) {

                                                    });
                                                  });
                                                } else if (first == 2) {
                                                  rewardAd.show();
                                                  getUserData();
                                                  updateRewardPoint();
                                                  first = 0;
                                                }
                                              } else  {
                                                shwoError(context, 'Check you internet connection.');
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
                                        '\$ ' + rewardEarnings,
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
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              TimerScreen()), (Route<dynamic> route) => false);
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

        },
      ),
    );
  }

}



String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/6300978111';
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/1033173712';
  }
  return null;
}

String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/5224354917';
  }
  return null;
}

