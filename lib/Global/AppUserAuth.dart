

import 'dart:io' as IO;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:gami/Screens/OTP_Screen.dart';
import 'package:gami/Screens/SetupAccount.dart';


gmailSignIn(context) async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  socailUserSetData(context, credential);
}

loginWithFacebook(context) async {
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:

      showLoading(context);
      final FacebookAccessToken accessToken = result.accessToken;
      print(accessToken.token);

      // var urlFacebook = Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture,gender,birthday&access_token=${accessToken.token}');

      // final graphResponse = await http.get(
      //     urlFacebook
      // );

      // var dictSocialProfile = json.decode(graphResponse.body);
      // print(dictSocialProfile);
      //
      // Map<String, dynamic> dictPicture = dictSocialProfile['picture'];
      // Map<String, dynamic> dictData = dictPicture['data'];
      // dictSocialProfile['picture'] = dictData['url'];
      // print(dictSocialProfile);
      // dismissLoading(context);

      // print(result.accessToken);
      // showLoading(context);
      // FacebookAccessToken myToken = result.accessToken;
      //
      // AuthCredential credential = FacebookAuthProvider.credential(myToken.token);
      // socailUserSetData(context, credential);

      break;
    case FacebookLoginStatus.cancelledByUser:
      Toast.show('Login cancelled by the user.', context,
          backgroundColor:Colors.red
      );
      break;

    case FacebookLoginStatus.error:
      Toast.show('${result.errorMessage}', context,
          backgroundColor:Colors.red
      );
      break;
  }

}

createUserWithEmailAndPassword(context, String userName, String email, String password,) async {
  print('createUserWithEmailAndPasswordcreateUserWithEmailAndPasswordcreateUserWithEmailAndPassword');
  print(strMobileNumber);

  showLoading(context);
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      return FirebaseFirestore.instance
          .collection(tblUserDetails).doc(strMobileNumber)
          .set({
        kUserID:value.user.uid,
        kUserName:userName,
        kEmail:value.user.email,
        kMobileNumber:strMobileNumber,
        kPassword:password,
        kDeviceType:IO.Platform.isIOS ? 'iOS' : 'Android',
        kRewardEarnings:'0',
        kDeviceToken:'',
        kProfilePicture: '',
        kInvitationCode: strInvitationCode
      }).then((value) {
        dismissLoading(context);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tabbar()),
        );

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             Tabbar()), (Route<dynamic> route) => false
        // );
      });

    });
  } on FirebaseAuthException catch (error) {
    dismissLoading(context);
    if (error.code == 'weak-password') {
      shwoError(context, error.message.toString());
    } else if (error.code == 'email-already-in-use') {
      shwoError(context, error.message.toString());
    }
  } catch (error) {
    shwoError(context, error.message.toString());
    dismissLoading(context);
  }
}

signInWithEmailAndPassword(context, String email, String password, ) async {
  showLoading(context);
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      return FirebaseFirestore.instance
          .collection(tblUserDetails)
          .doc(strMobileNumber)
          .update({
        kDeviceType:IO.Platform.isIOS ? 'iOS' : 'Android',
        kDeviceToken:'',
        kProfilePicture: '',
        kInvitationCode: strInvitationCode
      }).then((value) {
        dismissLoading(context);
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration:Duration(milliseconds:777),
              pageBuilder: (_, __, ___) => Tabbar(),
        ),
        );
      });
    });
  } on FirebaseAuthException catch (e) {
    dismissLoading(context);
    print(e.message.toString());
    if (e.code == 'weak-password') {
      shwoError(context, e.message.toString());
    } else if (e.code == 'email-already-in-use') {
      shwoError(context, e.message.toString());
    }
  } catch (e) {
    print(e.message.toString());
    shwoError(context, e.message.toString());
    dismissLoading(context);
  }
}

socailUserSetData(context, var credential) async {
  await FirebaseAuth.instance
      .signInWithCredential(credential).then((value) {

    FirebaseFirestore.instance
        .collection(tblUserDetails)
        .doc(value.user.email+kFireBaseConnect+value.user.uid)
        .set({
      kUserID: value.user.uid,
      kUserName: value.user.displayName,
      kEmail:value.user.email,
      kDeviceType: IO.Platform.isIOS ? 'iOS' : 'Android',
      kRewardEarnings:'0',
      kMobileNumber:'',
      kPassword:'',
      kDeviceToken:'',
      kProfilePicture: '',
      kInvitationCode: ''
    }).then((value) {
      Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration:Duration(milliseconds:777),
            pageBuilder: (_,__, ___) => Tabbar(),
      ),
      );
    });

  });

}

getOTP(context) async {
  showLoading(context);
  print(strMobileNumber);

  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: strMobileNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int resendToken) {
      strVerificationID = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  ).then((value) {
    dismissLoading(context);

    // if (isFromSignU`p`) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 777),
          pageBuilder: (_, __, ___) => OTP_Screen(),
        ),
      );
    // }
  }).catchError((error) {
    print(error.message.toString());
    dismissLoading(context);
    shwoError(context, error.message.toString());
  });

}

resendOTP(context) async {
  showLoading(context);
  print(strMobileNumber);

  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: strMobileNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int resendToken) {
      strVerificationID = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  ).then((value) {
    dismissLoading(context);
  }).catchError((error) {
    dismissLoading(context);
    shwoError(context, error.message.toString());
  });

}

void verifyOTP(context, String otp) async {
  print('isFromSignUpisFromSignUpisFromSignUp');
  print(isFromSignUp);

  showLoading(context);

  final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: strVerificationID, smsCode: otp
  );

  FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
    dismissLoading(context);

    isFromSignUp
        ? funcRegistered(context)
        : funcLogin(context);
  }).catchError((error) {
    print(error.message.toString());
    dismissLoading(context);
    shwoError(context, error.message.toString());
  });
}

funcRegistered(context) async {
  CollectionReference _cat = FirebaseFirestore.instance.collection(tblUserDetails);
  QuerySnapshot querySnapshot = await _cat.get();
  final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();

  bool isInvitatedCodeExist = false;
  bool isNumberRegistered = false;

  for (var userData in _docData) {
    if (strInvitatedCodeUsed == userData[kInvitationCode].toString()) {
      isInvitatedCodeExist = true;
      break;
    } else {
      isInvitatedCodeExist = false;
    }
  }

  for (var userData in _docData) {
    if (strMobileNumber == userData[kMobileNumber].toString()) {
      isNumberRegistered = true;
      break;
    } else {
      isNumberRegistered = false;
    }
  }

  if (_docData.length == 0 || (!isInvitatedCodeExist && !isNumberRegistered)) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 777),
        pageBuilder: (_, __, ___) => SetupAccount(),
      ),
    );
  } else {
    if (isInvitatedCodeExist && isNumberRegistered) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 777),
          pageBuilder: (_, __, ___) => SetupAccount(),
        ),
      );
    } else {
      if (isInvitatedCodeExist) {
        shwoError(context, 'Please Enter a Valid Invitation Code');
      } else if (isNumberRegistered) {
        shwoError(context, 'This number is registered already.');
      }
    }
  }
}

funcLogin(context) async {
  CollectionReference _cat = FirebaseFirestore.instance.collection(tblUserDetails);
  QuerySnapshot querySnapshot = await _cat.get();
  final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();

  bool isNumberRegistered = false;

  for (var userData in _docData) {
    if (strMobileNumber == userData[kMobileNumber].toString()) {
      isNumberRegistered = true;
      break;
    } else {
      isNumberRegistered = false;
    }
  }

  if (isNumberRegistered) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 777),
        pageBuilder: (_, __, ___) => Tabbar(),
      ),
    );
  } else {
    shwoError(context, 'This number is not registered.');
  }
}

// setInvitedList(context, String full_name, Uint8List image) {
setInvitedList(context, String full_name) {
  final currentUser = FirebaseAuth.instance.currentUser;

  FirebaseFirestore.instance
      .collection(tblInvitedList)
      .doc(strInvitatedCodeUsed)
      .collection(currentUser.uid)
      .doc(full_name.split(' ')[0]+kFireBaseConnect+strInvitationCode)
      .set({
    kID: DateTime.now().microsecondsSinceEpoch.toString(),
    kUserName: full_name,
    kProfilePicture: '',
    kInvitationCode: strInvitationCode,
    kCreatedTime: DateTime.now().millisecondsSinceEpoch.toString(),
  }).then((value) {
    // if (image != null && image.length > 0) {
    //   image.upload_Image_Uint8List(context, full_name, strInvitationCode);
    // }
  }).catchError((error) {
    shwoError(context, error.message.toString());
  });
}

shwoError(context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:Colors.red,
        content:Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:Colors.white,
              fontSize: 18
          ),
        ),
      )
  );
}

