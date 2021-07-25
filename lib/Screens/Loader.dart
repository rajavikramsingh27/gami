

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:gami/Screens/Tabbar.dart';




class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}



class _LoaderState extends State<Loader> with TickerProviderStateMixin {

  AnimationController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds:3000),
      vsync: this,
    );

    _controller.addListener((){
      if(_controller.isCompleted){
        _controller.repeat();
      }
    });

    Future.delayed(Duration(seconds:3),() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Tabbar()),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    return Scaffold(
      backgroundColor: HexColor(kThemeColor),
      body:Center(
          child:Container(
              height:100,
              width:100,
              child:Center(
                child:Stack(
                  children: [
                    Positioned(
                      left: 0,right:0,top:0,bottom: 0,
                      child:RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child:Hero(
                          tag:'Loader',
                          child:SvgPicture.asset(
                            'assets/images/loading.svg',
                            fit:BoxFit.fill,
                          ),
                        )
                      )
                    ),
                    Positioned(
                        child:Container(
                          alignment:Alignment.center,
                          child:Text(
                            'Loading...',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:14,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.normal
                            ),
                          ),
                        )
                    )
                  ],
                ),
              )
          )
      )
    );
  }
}



