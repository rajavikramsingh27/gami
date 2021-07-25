

import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          children: [
            Container(
                height:MediaQuery.of(context).size.height,
                width:MediaQuery.of(context).size.width,
                color:Colors.red,
                child:Image.asset(
                  'assets/images/bgShare.png',
                  fit: BoxFit.fill,
                  // height:MediaQuery.of(context).size.width,
                  // width:MediaQuery.of(context).size.height,
                ),
            ),
          ],
        )
    );
  }
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    heartbeatAnimation =
        Tween<double>(begin: 100.0, end: 150.0).animate(controller);
    controller.forward().whenComplete(() {
      controller.reverse();
    });

    /* Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacementNamed("/dashboard");
    });
*/
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heartbeatAnimation,
      builder: (context, widget) {
        return Scaffold(
          body:Stack(
              children:[
                Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                Row(),
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: heartbeatAnimation.value,
                ),
              ],
            ),
                Align(
              alignment:Alignment.center,
              child:Padding(
                padding:EdgeInsets.only(top: 200.0),
                child: Text(
                  "Flutter Tutorial",
                  style:TextStyle(
                      color:Colors.black,
                      fontSize:36.0,
                      fontWeight:FontWeight.w300),
                ),
              ),
            )
              ]),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}
