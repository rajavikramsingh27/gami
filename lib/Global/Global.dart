

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Screens/OnboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


String profilePictureEmpty(String fullName) {
  var arrDisplayName = fullName.split(' ');
  return (arrDisplayName.length == 1)
      ? arrDisplayName[0].toString()[0]
      : arrDisplayName[0].toString()[0]+arrDisplayName[1].toString()[0];
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

showError(context,String message) {
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

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color:HexColor(kThemeColor),
                borderRadius: BorderRadius.circular(6)),
            height: 80,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                CircularProgressIndicator(
                  backgroundColor:Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(width: 20),
                Text(
                  'Loading...',
                  style: TextStyle(
                      color: Colors.white,
                      // fontFamily:kFontRaleway,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ));
    },
  );
}

void dismissLoading(BuildContext context) {
  Navigator.pop(context);
}

logOut(context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are You Sure ?',
          style: TextStyle(
              color:Colors.red,
              fontSize:17,
              fontFamily:'OpenSans',
              fontWeight:FontWeight.w600
          ),
        ),
        content: Text(
          'Do you want to logout ?',
          style: TextStyle(
              color:Colors.red,
              fontSize:16,
              fontFamily:'OpenSans',
              fontWeight:FontWeight.normal
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: Text(
              "Log Out",
              style: TextStyle(
                  color:Colors.black,
                  fontSize:16,
                  fontFamily:'OpenSans',
                  fontWeight:FontWeight.normal
              ),
            ),
            onPressed: () async {
              final sharedPref = await SharedPreferences.getInstance();
              sharedPref.remove(kMobileNumber);

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  OnboardingScreen()), (Route<dynamic> route) => false);
            },
          ),
          new TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  color:Colors.blue,
                  fontSize:16,
                  fontFamily:'OpenSans',
                  fontWeight:FontWeight.normal
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      )
  );
}

String getImage(Map<String,dynamic> _embedded) {
  var arrFeaturedMedia = _embedded['_embedded']['wp:featuredmedia'];

  if (arrFeaturedMedia == null) {
    return '';
  } else {
    return 'https://gami.me/wp-content/uploads/'+arrFeaturedMedia[0]['media_details']['file'];
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

