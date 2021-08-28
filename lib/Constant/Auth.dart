
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Constant.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name;
  String email;
  String imageUrl;

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));

        socailUserSetData(context, credential);
      }
      final User currentUser =  _auth.currentUser;
      currentUser.getIdToken();
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      assert(user.uid == currentUser.uid);
      return user;
    }catch(e){
      print(e.toString());
    }
  }
  socailUserSetData(context, var credential) async {
    await FirebaseAuth.instance
        .signInWithCredential(credential).then((value) {
      FirebaseFirestore.instance
          .collection(tblUserDetails)
          .doc(strMobileNumber)
          .set({
        kUserID: value.user.uid,
        kUserName: value.user.displayName,
        kEmail:value.user.email,
        kDeviceType: Platform.isIOS ? 'iOS' : 'Android',
        kRewardEarnings:'0',
        kMobileNumber:'',
        kPassword:'',
        kDeviceToken:'',
        kProfilePicture: '',
      }).then((value) {
        Navigator.push(context, PageRouteBuilder(
            transitionDuration:Duration(milliseconds:777),
            pageBuilder: (_, __, ___) => Tabbar(),
          ),
        );
      });
    });
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}