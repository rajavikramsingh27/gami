import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gami/Screens/SignupScreen.dart';
import 'package:gami/Screens/LoginScreen.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:gami/Screens/Tabbar.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds:2),() async {
      var userDetails = FirebaseAuth.instance.currentUser;
      if (userDetails != null) {
        strMobileNumber = userDetails.phoneNumber;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tabbar()
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 12,
      width: isActive ? 24.0 : 12.0,
      decoration: BoxDecoration(
        color: isActive ? HexColor(kMagento) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: HexColor(kThemeColor),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height/3)*2+20
                  ,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding01.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            //SizedBox(height: 30.0),

                            Center(
                              child: Text(
                                'Welcome to Gami',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontFamily: 'Rajdhani',
                                  fontWeight: FontWeight.bold,

                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                              child: Center(
                                child: Text(
                                  'A community-driven battle royale game with augmented reality missions where players can monetize. a community-driven battle royale game with augmented reality',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding02.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                              child: Center(
                                child: Text(
                                  'Immersive gaming experience',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontFamily: 'Rajdhani',
                                    fontWeight: FontWeight.bold,

                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                              child: Center(
                                child: Text(
                                  'Empires and civilisations that your character belongs to- which can be leveraged for more earning power by strategical',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding03.png',
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Strategical game play',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontFamily: 'Rajdhani',
                                  fontWeight: FontWeight.bold,

                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
                              child: Center(
                                child: Text(
                                  'Build empires, re-write history and taste victory! Collect #NFT Play #AugmentedReality Earn #Defi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                ),

                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 30.0),
                  child:
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(kMagento),
                      borderRadius: BorderRadius.circular(12),
                      // border:Border.all(
                      //     color:Colors.white,
                      //     width:1
                      // )
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SignupScreen();
                        }));
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w500

                        ),
                      ),
                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 30.0),
                  child:
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: HexColor(kMagento),
                      borderRadius: BorderRadius.circular(12),
                      // border:Border.all(
                      //     color:Colors.white,
                      //     width:1
                      // )
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return LoginScreen();
                        }));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w500

                        ),
                      ),
                    ),
                  ),

                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
