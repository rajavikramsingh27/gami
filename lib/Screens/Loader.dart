

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// class Loader extends StatefulWidget {
//   @override
//   _LoaderState createState() => _LoaderState();
// }
//
// class _LoaderState extends State<Loader> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//     );
//   }
// }



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

    Future.delayed(Duration(seconds:1),() {
      getNewsPosts(context);
    });

  }

  getNewsPosts(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile
        || connectivityResult == ConnectivityResult.wifi) {
      // showLoading(context);
      final response = await http.get(Uri.parse(wordPress_API));
      // dismissLoading(context);

      if (response.statusCode == 200) {
        arrNewsPosts = List<Map<String, dynamic>>.from(jsonDecode(response.body));

        // for (var _embedded in arrNewsPosts) {
        //   // print('hellohellohellohellohello');
        //   // print(asdf['_embedded']['wp:featuredmedia']);
        //   var arrFeaturedMedia = _embedded['_embedded']['wp:featuredmedia'];
        //   // var arrFeaturedMedia = List<Map<String, dynamic>>.from(asdf['_embedded']['wp:featuredmedia']);
        //   // print(arrFeaturedMedia);
        //
        //   if (arrFeaturedMedia == null) {
        //     // print('asdf');
        //   } else {
        //     // print(arrFeaturedMedia);
        //     print('https://gami.me/wp-content/uploads/'+arrFeaturedMedia[0]['media_details']['file']);
        //   }
        // }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tabbar()),
        );
      } else {
        throw Exception('Failed to load album');
      }
    } else {
      shwoError(context, 'Check you internet connection.');
    }

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


