import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';


class TimerScreen extends StatefulWidget {

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int maxHours = 24;
  int maxMin = 60;
  int hours = 0;
  int minutes = 0;

  String statusStop = 'Mining Stopped';
  String statusMining = 'Currently Mining';
  String statusText = 'Mining Stopped';

  String descStop = 'Press the circle to start mining';
  String descMining = 'Reset the clock at anytime by pressing the circle again';
  String descText = 'Press the circle to start mining';

  var isMining = false;
  Timer timer;




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
        Container(
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
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height:35,),
                    //NOTE:
                    //NOTE: Logo at the top of the screen
                    Image.asset(
                      'assets/images/LOGO.png',
                      width:MediaQuery.of(context).size.width/5,
                      fit:BoxFit.fill,
                    ),
                    SizedBox(height: size.height * 0.1),
                    buildMoney(),
                    SizedBox(height: size.height * 0.10),
                    buildTimer(),
                    SizedBox(height: size.height * 0.1),
                    buildStatusText(),
                    SizedBox(height: size.height * 0.05),
                    buildContinueButton(),
                  ],
                ),
              ),
            )

        ),
    );
  }

  Widget buildMoney()
  {
    return
      //Center(
      //  child:
        Column(
          children: [
            Text(
              "\$45.23",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 28,
              ),

            ),
            Text(
              "0.025 GBUCKS/hr",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: HexColor(kMagento),
                fontSize: 14,
              ),
            ),
          ],
     //   )
      );
  }

  Widget buildTimer() => SizedBox(
    width: 200,
    height: 200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: hours/maxHours,
          // color: HexColor(kMagento),
          backgroundColor: Colors.white,
          strokeWidth: 8,
        ),
        Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
            ),
            child:
            RawMaterialButton(
              child:
                Center(child: buildTime()),
              onPressed: () {
                if(isMining == false) {
                  isMining = true;
                  setState(() => hours = 24);
                  startTimer();
                }
              },
              elevation: 2.0,
              fillColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              shape: CircleBorder(),
            )
        )
      ],
    ),

  );

  Widget buildTime()
  {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$hours',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 36,
            ),
          ),
          Text(
            'h',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 36,
            ),
            //textAlign: TextAlignVertical.bottom,

          ),
        ],
      ),
    );
  }

  Widget buildStatusText()
  {
    return
      //Center(
      //  child:
      Column(
        children: [

          Text(
            statusText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            descText,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        //   )
      );
  }



  Widget buildContinueButton()
  {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        child: Container(
          height:50,
          width: double.infinity,
          margin:EdgeInsets.only(left:20,right:20),
          decoration:BoxDecoration(
              color: HexColor(kMagento),
              borderRadius:BorderRadius.circular(12)
          ),
          child:TextButton(
              child:Text(
                'CLOSE',
                style:TextStyle(
                    color:Colors.white,
                    fontSize:16,
                    fontFamily:'OpenSans',
                    fontWeight:FontWeight.w500
                ),
              ),
              onPressed:() {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    Tabbar()), (Route<dynamic> route) => false);
              }),
        ),
      ),
    );
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if( hours > 0) {
        setState(() => hours--);
        setState(() => statusText = statusMining);
        setState(() => descText = descMining);
      } else {
        timer.cancel();
        isMining = false;
        setState(() => statusText = statusStop);
        setState(() => descText = descStop);
      }

    });
  }







}