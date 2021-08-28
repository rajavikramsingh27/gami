import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  // var _isLoggedIn = false;
  var txtEmailAddress = TextEditingController();
  var txtPassword = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/plus.login',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/plus.profile.emails.read'
  ]);
  var facebookLogin = FacebookLogin();
  var isTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor(
          kThemeColor
      ),
      appBar:AppBar(
        elevation:0,
        centerTitle:true,
        backgroundColor: Colors.transparent,
        brightness:Brightness.dark,
        title:Image.asset(
          'assets/images/LOGO.png',
          width:MediaQuery.of(context).size.width-(145*2),
          fit:BoxFit.fill,
          // fit:BoxFit.fitWidth,
        ),
        automaticallyImplyLeading: false,
      ),
      body:SafeArea(
        bottom:false,
        child:SingleChildScrollView(
          padding:EdgeInsets.only(bottom:30),
          child:Column(
            children: [
              SizedBox(height:30,),
              Hero(
                tag:'registrationPlayButton',
                child:Image.asset(
                  'assets/images/white-blue_TEXT.png',
                  width:MediaQuery.of(context).size.width-(80*2),
                  fit:BoxFit.fill,
                ),
              ),
              SizedBox(height:20,),
              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(
                  controller: txtEmailAddress,
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Email Address',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:16,),
              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Password',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:30,),
              Container(
                  height:50,
                  margin:EdgeInsets.only(left:40,right:40),
                  decoration:BoxDecoration(
                    // color:Colors.white,
                      borderRadius:BorderRadius.circular(4)
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:EdgeInsets.only(left:4,right:4),
                        width:140,
                        decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(3)
                        ),
                        child:TextButton(
                            child:Text(
                              'Login',
                              style:TextStyle(
                                  color:Colors.black,
                                  fontSize:15,
                                  fontFamily:'OpenSans',
                                  fontWeight:FontWeight.normal
                              ),
                            ),
                            onPressed:() {
                              if (txtEmailAddress.text.isEmpty) {
                                shwoError(context, 'Enter your email.');
                              } else if (!txtEmailAddress.text.isValidEmail()) {
                                shwoError(context, 'Enter a valid email.');
                              } else if (txtPassword.text.isEmpty) {
                                shwoError(context, 'Enter your password.');
                              } else {
                                signInWithEmailAndPassword(
                                    context,
                                    txtEmailAddress.text,
                                    txtPassword.text
                                );

                              }
                            }),
                      ),
                      Container(
                        child:Text(
                          'Or',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize:22,
                              fontFamily:'OpenSans',
                              fontWeight:FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child:IconButton(
                                icon:SvgPicture.asset(
                                  'assets/images/search.svg',
                                  height:30,
                                ),
                                onPressed:() async {
                                  // authUser();

                                },
                              )
                          ),
                          // SizedBox(width:10,),
                          Container(
                              child:IconButton(
                                icon:SvgPicture.asset(
                                  'assets/images/facebook.svg',
                                  height:32,
                                ),
                                onPressed:() {
                                  loginWithFB();
                                },
                              )
                          ),
                        ],
                      )
                    ],
                  )
              ),
              SizedBox(height:16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style:TextStyle(
                          color:Colors.white,
                          fontSize:14,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.normal
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pop(context);
                      },
                      text:' SignUp',
                      style:TextStyle(
                          decoration: TextDecoration.underline,
                          color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.bold
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void authUser() async {
  //   try {
  //     await Auth().signOutGoogle();
  //     await Auth().signInWithGoogle(context).then((user) {
  //       if (user != null) {
  //
  //       } else {
  //
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  loginWithFB() async {
    _logout();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=first_name,last_name,name,email,picture.height(200)&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        Toast.show(profile['id'].toString(), context);
        AuthCredential credential = FacebookAuthProvider.credential(token);
        socailUserSetData(context, credential);
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          // _isLoggedIn = false
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          // _isLoggedIn = false
        });
        break;
    }
  }

  void _logout() {
    facebookLogin.logOut();

    setState(() {
      // _isLoggedIn = false;
    });
  }
}




