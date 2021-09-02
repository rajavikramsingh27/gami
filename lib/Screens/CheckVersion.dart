

import 'package:flutter/material.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';


class CheckVersion extends StatefulWidget {
  @override
  _CheckVersionState createState() => _CheckVersionState();
}

class _CheckVersionState extends State<CheckVersion> {
  PackageInfo packageInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      packageInformation = packageInfo;

      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor(kThemeColor),
                  HexColor(kThemeColor2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset(
                'assets/images/LOGO.png',
                width:MediaQuery.of(context).size.width/5,
                fit:BoxFit.fill,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-113,
                padding: EdgeInsets.only(
                  left: 20, right: 20
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gami App has version latest version '+dictAppDetails['version'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily:'OpenSans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'You have installed a very old version '+packageInformation.version,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily:'OpenSans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    Container(
                      height:50,
                      width: double.infinity,
                      margin:EdgeInsets.only(left:20,right:20),
                      decoration:BoxDecoration(
                          color: HexColor(kMagento),
                          borderRadius:BorderRadius.circular(12)
                      ),
                      child:TextButton(
                          child:Text(
                            'Click to install latest version',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:16,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w500
                            ),
                          ),
                          onPressed:() async {
                            final _url = Platform.isIOS ? dictAppDetails['appStore'].toString() : dictAppDetails['playStore'].toString();
                            await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                          }),
                    ),
                  ],
                  //   )
                ),
              )
            ],
          ),

      ),
    );
  }

}
