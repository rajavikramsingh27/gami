import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gami/Screens/SignupScreen.dart';

import '../Constant/Constant.dart';
import '../Global/Global.dart';

class MessageScreen extends StatelessWidget{

  var smalltext = 'Thank you for registering';
  var largetext = 'Your GAMI Journey Starts Now';

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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[


                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child:buildText(smalltext, false),
                  )
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child:buildText(largetext, true),
                  )
                ),

                SizedBox(height: 150),
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
                        'CONTINUE',
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

  Widget buildText(String text, bool isLarge)
  {
      if(isLarge == true){
        return
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Rajdhani',
              color: Colors.white,
              fontSize: 28,
            ),
              textAlign: TextAlign.center
          );
      }
      else
      {
        return
          Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 21,
              ),
              textAlign: TextAlign.center
          );
      }
  }
}
