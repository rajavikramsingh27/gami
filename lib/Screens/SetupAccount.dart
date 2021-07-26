
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class SetupAccount extends StatefulWidget {
  @override
  _SetupAccountState createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {

  final txtUserName = TextEditingController();
  final txtEmail = TextEditingController();
  // final txtPassword = TextEditingController();
  // final txtReEnterPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor(kThemeColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 34,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Setup Account.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize:27,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor(kThemeColor),
                    HexColor(kThemeColor2),
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                )
            ),
            child: Center(
              child:
              buildSTatusText(),
            )

        ),
      ),
    );
  }

  Widget buildSTatusText()
  {
    return
      Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Center(
            //   child: Image(
            //     image: AssetImage(
            //       'assets/images/onboarding01.png',
            //     ),
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            SizedBox(height: 100,),
            // Container(
            //   width: MediaQuery
            //       .of(context)
            //       .size
            //       .width - 90,
            //   child: Text(
            //     "Setup Account.",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize:27,
            //         fontFamily: 'Rajdhani',
            //         fontWeight: FontWeight.bold
            //     ),
            //   ),
            // ),
            // SizedBox(height:20,),
            Container(
              height:50,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(4)
              ),
              child:
              TextFormField(
                controller: txtUserName,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly
                // ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                    hintText: 'USER NAME',
                    hintStyle:TextStyle(
                      // color:Colors.white,
                        fontSize:12,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w600
                    ),
                    contentPadding:EdgeInsets.only(left:10,right:10)
                  // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                ),
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
              child: TextFormField(
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly
                // ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                    hintText: 'Email',
                    hintStyle:TextStyle(
                      // color:Colors.white,
                        fontSize:12,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w600
                    ),
                    contentPadding:EdgeInsets.only(left:10,right:10)
                  // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                ),
              ),
            ),
            // SizedBox(height:20,),
            // Container(
            //   height:50,
            //   margin:EdgeInsets.only(left:40,right:40),
            //   decoration:BoxDecoration(
            //       color:Colors.white,
            //       borderRadius:BorderRadius.circular(4)
            //   ),
            //   child:
            //   TextFormField(
            //     controller: txtPassword,
            //     obscureText: true,
            //     // inputFormatters: <TextInputFormatter>[
            //     //   FilteringTextInputFormatter.digitsOnly
            //     // ],
            //     decoration: InputDecoration(
            //         border: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         enabledBorder: InputBorder.none,
            //         errorBorder: InputBorder.none,
            //         disabledBorder: InputBorder.none,
            //         // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
            //         hintText: 'Password',
            //         hintStyle:TextStyle(
            //           // color:Colors.white,
            //             fontSize:12,
            //             fontFamily:'OpenSans',
            //             fontWeight:FontWeight.w600
            //         ),
            //         contentPadding:EdgeInsets.only(left:10,right:10)
            //       // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            //     ),
            //   ),
            // ),
            // SizedBox(height:20,),
            // Container(
            //   height:50,
            //   margin:EdgeInsets.only(left:40,right:40),
            //   decoration:BoxDecoration(
            //       color:Colors.white,
            //       borderRadius:BorderRadius.circular(4)
            //   ),
            //   child:
            //   TextFormField(
            //     controller: txtReEnterPassword,
            //     obscureText: true,
            //     // inputFormatters: <TextInputFormatter>[
            //     //   FilteringTextInputFormatter.digitsOnly
            //     // ],
            //     decoration: InputDecoration(
            //         border: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         enabledBorder: InputBorder.none,
            //         errorBorder: InputBorder.none,
            //         disabledBorder: InputBorder.none,
            //         // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
            //         hintText: 'Re-Enter Password',
            //         hintStyle:TextStyle(
            //           // color:Colors.white,
            //             fontSize:12,
            //             fontFamily:'OpenSans',
            //             fontWeight:FontWeight.w600
            //         ),
            //         contentPadding:EdgeInsets.only(left:10,right:10)
            //       // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            //     ),
            //   ),
            // ),
            SizedBox(height:60,),
            Container(
              height:50,
              width: double.infinity,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color: HexColor(kMagento),
                  borderRadius:BorderRadius.circular(12)
              ),
              child:TextButton(
                  child:Text(
                    'SAVE',
                    style:TextStyle(
                        color:Colors.white,
                        fontSize:16,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w500
                    ),
                  ),
                  onPressed:() {
                    if (txtUserName.text.isEmpty) {
                      shwoError(context, 'Enter a user name');
                    } else if (txtEmail.text.isEmpty) {
                      shwoError(context, 'Enter your email');
                    } else if (!txtEmail.text.isValidEmail()) {
                      shwoError(context, 'Enter a valid email');
                    }
                    // else if (txtPassword.text.isEmpty) {
                    //   shwoError(context, 'Enter a password');
                    // } else if (txtReEnterPassword.text.isEmpty) {
                    //   shwoError(context, 'Re-Enter a password');
                    // } else if (txtPassword.text != txtReEnterPassword.text) {
                    //   shwoError(context, 'ReEntered Password must match with Password');
                    // }

                    else {
                      createInvitationCode();
                    }

                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    // Tabbar()), (Route<dynamic> route) => false);
                  }),
            ),
          ],
        ),
      );
  }

  createInvitationCode() async {

    showLoading(context);
    var userDetails = FirebaseAuth.instance.currentUser;
    String firstThreeCharUserID = '';

      for (int i=0;i<=3;i++) {
        firstThreeCharUserID += userDetails.uid[i];
      }

      var arrDisplayName = txtUserName.text.split(' ');
      print(arrDisplayName[0]+firstThreeCharUserID);

      strInvitationCode = arrDisplayName[0]+firstThreeCharUserID;
      print(strInvitationCode);
      dismissLoading(context);

      createUserWithEmailAndPassword(context, txtUserName.text, txtEmail.text, '123456');

      setInvitedList(context, txtUserName.text);
  }

}
