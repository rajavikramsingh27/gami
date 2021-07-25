

import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Share extends StatefulWidget {
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> with SingleTickerProviderStateMixin {

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
        // backgroundColor:HexColor(kThemeColor),
        body:Stack(
          children:[
            Positioned(
                top:0,left:0,right: 0,
                child:SafeArea(
                  child:Center(
                    child:Image.asset(
                      'assets/images/LOGO.png',
                      width:MediaQuery.of(context).size.width-(145*2),
                      fit:BoxFit.fill,
                      // fit:BoxFit.fitWidth,
                    ),
                  ),
                )
            ),
            Positioned(
              left:0,right: 0,bottom: 0,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                    width:MediaQuery.of(context).size.width-120,
                    child:FittedBox(
                      fit: BoxFit.fill,
                      child:Text(
                        'Lets Get Started',
                        style:TextStyle(
                            color:HexColor(kMagento),
                            // fontSize:27,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      width:MediaQuery.of(context).size.width-120,
                      child:SizedBox(
                        child:Text(
                          'Invite your friends to join the GAMI Network with your Innovation code',
                          style:TextStyle(
                              color:Colors.white,
                              // fontSize:15,
                              fontFamily:'OpenSans',
                              fontWeight:FontWeight.w600
                          ),
                        ),
                      )
                  ),
                  SizedBox(height:24),
                  Container(
                    height:46,
                    width:MediaQuery.of(context).size.width-120,
                    padding:EdgeInsets.only(left: 6,right: 7),
                    decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius:BorderRadius.circular(5),
                        border:Border.all(
                            color:Colors.white,
                            width:3
                        )
                    ),
                    child:TextButton(
                        onPressed:() {

                        },
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AZAD123',
                              style:TextStyle(
                                  color:Colors.black,
                                  fontSize:14,
                                  fontFamily:'OpenSans',
                                  fontWeight:FontWeight.w500
                              ),
                            ),
                            Text(
                              'Copy',
                              style:TextStyle(
                                  color:HexColor(kMagento),
                                  fontSize:14,
                                  fontFamily:'OpenSans',
                                  fontWeight:FontWeight.w500
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height:24),
                  Container(
                    height:46,
                    width:MediaQuery.of(context).size.width-120,
                    decoration:BoxDecoration(
                      color:HexColor(kMagento),
                      borderRadius:BorderRadius.circular(5),
                      // border:Border.all(
                      //     color:Colors.white,
                      //     width:1
                      // )
                    ),
                    child:TextButton(
                      onPressed:() {

                      },
                      child:Text(
                        'Invite your contacts',
                        style:TextStyle(
                            color:Colors.white,
                            fontSize:14,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:24),
                  Container(
                    height:46,
                    width:MediaQuery.of(context).size.width-120,
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(5),
                        border:Border.all(
                            color:Colors.white,
                            width:3
                        )
                    ),
                    child:TextButton(
                      onPressed:() {

                      },
                      child:Text(
                        'Share',
                        style:TextStyle(
                            color:Colors.white,
                            fontSize:14,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:MediaQuery
                        .of(context)
                        .padding
                        .bottom+130,
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

}

