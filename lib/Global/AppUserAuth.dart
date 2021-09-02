

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dart_notification_center/dart_notification_center.dart';



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
      // final FacebookAccessToken accessToken = result.accessToken;

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
      }).then((value) async {
        dismissLoading(context);

        final sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(kMobileNumber, strMobileNumber);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tabbar()),
        );

      });

    });
  } on FirebaseAuthException catch (error) {
    dismissLoading(context);
    if (error.code == 'weak-password') {
      showError(context, error.message.toString());
    } else if (error.code == 'email-already-in-use') {
      showError(context, error.message.toString());
    }
  } catch (error) {
    showError(context, error.message.toString());
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
      }).then((value) async {
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
      showError(context, e.message.toString());
    } else if (e.code == 'email-already-in-use') {
      showError(context, e.message.toString());
    }
  } catch (e) {
    print(e.message.toString());
    showError(context, e.message.toString());
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
          pageBuilder: (_, __, ___) => OTPScreen(),
        ),
      );
    // }
  }).catchError((error) {
    print(error.message.toString());
    dismissLoading(context);
    showError(context, error.message.toString());
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
    print('strVerificationIDstrVerificationIDstrVerificationID');
    print(strVerificationID);

    dismissLoading(context);
  }).catchError((error) {
    dismissLoading(context);
    showError(context, error.message.toString());
  });

}

void verifyOTP(context, String otp) async {
  showLoading(context);

  try {
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
      showError(context, error.message.toString());
    });
  } catch (error) {
    dismissLoading(context);
    showError(context, 'strVerificationID is null '+error.message.toString());
  }
}

funcRegistered(context) async {
  CollectionReference _cat = FirebaseFirestore.instance.collection(tblUserDetails);
  QuerySnapshot querySnapshot = await _cat.get();
  final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();

  bool isInvitatedCodeExist = false;
  bool isNumberRegistered = false;

  for (var userData in _docData) {
    if (userData[kInvitatedCodeUsed] != null) {
      if (strInvitatedCodeUsed == userData[kInvitationCode].toString()) {
        isInvitatedCodeExist = true;
        break;
      } else {
        isInvitatedCodeExist = false;
      }
    }
  }

  for (var userData in _docData) {
    if (userData[kMobileNumber] != null) {
      if (strMobileNumber == userData[kMobileNumber].toString()) {
        isNumberRegistered = true;
        break;
      } else {
        isNumberRegistered = false;
      }
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
        showError(context, 'Please Enter a Valid Invitation Code');
      } else if (isNumberRegistered) {
        showError(context, 'This number is registered already.');
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
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(kMobileNumber, strMobileNumber);

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 777),
        pageBuilder: (_, __, ___) => Tabbar(),
      ),
    );
  } else {
    showError(context, 'This number is not registered.');
  }
}

setInvitedList(context, String fullName) {
  final time = DateTime.now().microsecondsSinceEpoch.toString();

  FirebaseFirestore.instance
      .collection(tblInvitedList)
      .doc(strInvitatedCodeUsed)
      .collection(strInvitatedCodeUsed)
      .doc(fullName.split(' ')[0]+kFireBaseConnect+strInvitationCode)
      .set({
    kID: time,
    kProfilePicture: '',
    kUserName: fullName,
    kInvitationCode: strInvitationCode,
    kCreatedTime: time,
  }).then((value) {
    final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    getGlobalSettings(context, strInvitatedCodeUsed, strDate, 'invite');
  }).catchError((error) {
    showError(context, error.message.toString());
  });
}

getGlobalSettings(context, String fireBasePath, String strDate, String globalKey) async {
  final snapShot = await FirebaseFirestore.instance.collection(tblGlobalSettings).get();
  final arrGlobalSettings = snapShot.docs.map((doc) => doc.data()).toList();

  getTransactions(context, fireBasePath, strDate, {globalKey: arrGlobalSettings[0][globalKey].toString()});
}

getTransactions(context, String fireBasePath, String strDate, Map<String, dynamic> dictTransaction) async {
  // final strDate = '01 Sep 2021';
  // final strDate = '31 Aug 2021';
  // final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  final docSnap = await FirebaseFirestore.instance
      .collection(tblTransactions)
      .doc(fireBasePath)
      .collection(fireBasePath)
      .doc(strDate)
      .get();

  final docSnapData = docSnap.data();

  String key = dictTransaction.keys.elementAt(0);
  String value = dictTransaction.values.elementAt(0);
  int transactions = 0;

  if (docSnapData != null) {
    transactions = int.parse(docSnapData[key].toString());
    transactions = transactions+int.parse(value);
  }

  final dictTransactionUpdate = {
    key: (docSnapData == null) ? value : transactions.toString()
  };

  (docSnapData == null)
      ? setTransactions(context, fireBasePath, strDate, dictTransactionUpdate)
      : updateTransactions(fireBasePath, strDate, dictTransactionUpdate) ;
}

setTransactions(context, String fireBasePath, String strDate, Map<String, dynamic> dictTransaction) {
  final time = DateTime.now().microsecondsSinceEpoch.toString();

  // final strDate = '01 Sep 2021';
  // final strDate = '31 Aug 2021';
  // final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  FirebaseFirestore.instance
      .collection(tblTransactions)
      .doc(fireBasePath)
      .collection(fireBasePath)
      .doc(strDate)
      .set({
    kID: time,
    kCreatedTime: strDate,
    'currency': "\$",
    'attention': '0',
    'invite': '0',
    'mining': '0',
  }).then((value) {
    updateTransactions(fireBasePath, strDate, dictTransaction);
  }).catchError((error) {
    showError(context, error.message.toString());
  });

}

updateTransactions( String fireBasePath, String strDate, Map<String, dynamic> dictTransaction) {
  // final strDate = '01 Sep 2021';
  // final strDate = '31 Aug 2021';
  // final strDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  FirebaseFirestore.instance
      .collection(tblTransactions)
      .doc(fireBasePath)
      .collection(fireBasePath)
      .doc(strDate)
      .update( dictTransaction ).then((value) {
    DartNotificationCenter.post(channel:tblTransactions);
  });
}

// updateRewardInvitedUser() {
//   int rewardEarnings = int.parse(dictInvitedUser[kRewardEarnings].toString());
//   rewardEarnings = rewardEarnings+5;
//   FirebaseFirestore.instance.collection(tblUserDetails)
//       .doc(dictInvitedUser[kMobileNumber].toString()).update({
//     kRewardEarnings: rewardEarnings.toString(),
//   });
//
// }

