
import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:gami/Screens/Profile.dart';


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  double widthAnim = 200;
  double heightAnim = 500;


  @override
  void initState() {
    super.initState();


    Future.delayed(Duration(microseconds:5),() {
      widthAnim = MediaQuery.of(context).size.width;
      heightAnim = MediaQuery.of(context).size.height;

      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:HexColor(kThemeColor),
      body:Stack(
        children: [
          Container(
              height:MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              child:Stack(
                children: [
                  Positioned(
                    left: 0,right: 0,top: 0,bottom: 0,
                    child:Container(
                      color: HexColor(kThemeColor).withOpacity(0.58),
                    ),
                  )
                ],
              )
          ),
          Positioned(
            left: 0,right: 0,
              top: 0,
              // bottom: 0,
            child:SafeArea(
              child:Stack(
                children: [
                 Center(
                   child:Image.asset(
                     'assets/images/LOGO.png',
                     width:MediaQuery.of(context).size.width-(145*2),
                     fit:BoxFit.fill,
                   ),
                 ),
                  Container(
                    width:MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile()),
                            );
                          },
                          child:Text(
                              'PROFILE',
                              style:TextStyle(
                                  color:Colors.white,
                                  fontSize:25,
                                  fontFamily:'OpenSans',
                                  fontWeight:FontWeight.w600
                              ),
                            ),
                        ),
                        SizedBox(height:24),
                        TextButton(
                          onPressed:() {

                          },
                          child:Text(
                            'SETTING',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:25,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height:24),
                        TextButton(
                          onPressed:() {

                          },
                          child:Text(
                            'BLOG',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:25,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height:24),
                        TextButton(
                          onPressed:() {

                          },
                          child:Text(
                            'CONTACT US',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:25,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }

}
