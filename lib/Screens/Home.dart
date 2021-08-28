

import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


// double size_Watch_Earn_Text = 5;

bool isAnimated = false;


class _HomeState extends State<Home> with TickerProviderStateMixin {

  bool isVisible = false;

  double heightWatchEarn = 100;

  double whiteBlueTextLeftPadding = 0;
  var whiteBlueTextAnimTime = 0;

  double widthAnim = 200;
  double heightAnim = 500;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whiteBlueTextLeftPadding = 400;

    Future.delayed(Duration(microseconds:5),() {

      isVisible = true;
      widthAnim = MediaQuery.of(context).size.width;
      heightAnim = MediaQuery.of(context).size.height;

      if (!isAnimated) {
        sizeWatchEarnText = 20;

        Future.delayed(Duration(seconds:1),() {
          isAnimated = true;
        });
      }

      heightWatchEarn = 10;

      setState(() {

      });
    });

    Future.delayed(Duration(milliseconds:50),() {
      if (isAnimated) {
        whiteBlueTextLeftPadding = (MediaQuery.of(context).size.width/2)-(MediaQuery.of(context).size.width-(80*2))/2;
      }

      setState(() { });

    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:HexColor(kThemeColor),
        body:SingleChildScrollView(
          padding:EdgeInsets.only(
              bottom:MediaQuery
                  .of(context)
                  .padding
                  .bottom+70
          ),
          child:Column(
            children: [
              Stack(
                children: [
                  Positioned(
                      child:Align(
                        alignment:isAnimated ? Alignment.centerLeft : Alignment.centerRight,
                        child:AnimatedSize(
                          curve:Curves.fastOutSlowIn,
                          vsync:this,
                          duration:Duration(milliseconds:600),
                          child:Image.asset(
                            'assets/images/bg.png',
                            width:widthAnim,
                            height:heightAnim,
                            fit:BoxFit.fill,
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      left:0,right:0,
                      child:SafeArea(
                        child:Column(
                          children: [
                            Image.asset(
                              'assets/images/LOGO.png',
                              width:MediaQuery.of(context).size.width-(145*2),
                              fit:BoxFit.fill,
                              // height:35,
                              // fit:BoxFit.fitWidth,
                            ),
                            SizedBox(height:35,),
                            Column(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      child:AnimatedSize(
                                        curve:Curves.fastOutSlowIn,
                                        vsync:this,
                                        duration:Duration(milliseconds:600),
                                        child:Container(
                                          alignment:Alignment.centerRight,
                                          // color:Colors.white,
                                          width:whiteBlueTextLeftPadding,
                                          height:(MediaQuery.of(context).size.width-(80*2))*1.4,
                                        ),
                                      ),
                                      visible:isAnimated,
                                    ),
                                    Container(
                                        padding:!isAnimated ?
                                        EdgeInsets.only(
                                            left: (MediaQuery.of(context).size.width/2)-(MediaQuery.of(context).size.width-(80*2))/2
                                        ) : EdgeInsets.only(
                                            left:0
                                        ),
                                        child:Hero(
                                          tag:'Loader',
                                          child:Image.asset(
                                            'assets/images/white-blue_TEXT.png',
                                            width:MediaQuery.of(context).size.width-(80*2),
                                            height:(MediaQuery.of(context).size.width-(80*2))*1.4,
                                            fit:BoxFit.fill,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height:20,),
                                FlatButton(
                                  child:Hero(
                                    tag: "registrationPlayButton",
                                    child:Image.asset(
                                      'assets/images/play.png',
                                      width:MediaQuery.of(context).size.width-(135*2),
                                      fit:BoxFit.fill,
                                    ),
                                  ),
                                  onPressed:() { },
                                ),
                                isAnimated
                                    ? AnimatedSize(
                                  curve:Curves.fastOutSlowIn,
                                  vsync:this,
                                  duration:Duration(milliseconds:800),
                                  child:SizedBox(height:heightWatchEarn),
                                ) :  SizedBox(height:10),
                                Visibility(
                                  visible:!isAnimated,
                                  child:AnimatedSize(
                                    curve:Curves.fastOutSlowIn,
                                    vsync:this,
                                    duration:Duration(milliseconds:800),
                                    child:Text(
                                      'Watch & earn',
                                      style:TextStyle(
                                          color:Colors.white,
                                          fontSize: sizeWatchEarnText,
                                          fontFamily:'OpenSans',
                                          fontWeight:FontWeight.w100
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:isAnimated,
                                  child:Text(
                                    'Watch & earn',
                                    style:TextStyle(
                                        color:Colors.white,
                                        fontSize: sizeWatchEarnText,
                                        fontFamily:'OpenSans',
                                        fontWeight:FontWeight.normal
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              Visibility(
                visible:isVisible,
                child:Column(
                  children: [
                    SizedBox(height:40,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      margin:EdgeInsets.only(left:16),
                      padding:EdgeInsets.only(left:16,top:0,bottom:0),
                      decoration:BoxDecoration(
                          border:Border(
                            left:BorderSide(
                                color:HexColor(kMagento),
                                width:3
                            ),
                          )
                      ),
                      alignment:Alignment.centerLeft,
                      child:Text(
                        'Team',
                        textAlign:TextAlign.center,
                        style:TextStyle(
                            color:Colors.white,
                            fontSize:25,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height:24,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      height:111,
                      child:ListView.builder(
                          padding:EdgeInsets.only(left:16,right:16),
                          scrollDirection: Axis.horizontal,
                          itemCount: 30,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height:74,
                              width:74,
                              margin:EdgeInsets.only(right:16),
                              child:ClipRRect(
                                  borderRadius:BorderRadius.circular(37),
                                  child:Column(
                                    children: [
                                      Image.asset('assets/images/user.png'),
                                      SizedBox(height:10,),
                                      Text(
                                        'Brenda',
                                        textAlign:TextAlign.center,
                                        style:TextStyle(
                                            color:Colors.white,
                                            fontSize:13,
                                            fontFamily:'OpenSans',
                                            fontWeight:FontWeight.normal
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              decoration:BoxDecoration(
                                // color:Colors.red,
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height:40,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      margin:EdgeInsets.only(left:16),
                      padding:EdgeInsets.only(left:16,top:0,bottom:0),
                      decoration:BoxDecoration(
                          border:Border(
                            left:BorderSide(
                                color:HexColor(kMagento),
                                width:3
                            ),
                          )
                      ),
                      alignment:Alignment.centerLeft,
                      child:Text(
                        'News',
                        textAlign:TextAlign.center,
                        style:TextStyle(
                            color:Colors.white,
                            fontSize:25,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height:24,),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      height:400,
                      child:ListView.builder(
                          physics:NeverScrollableScrollPhysics(),
                          padding:EdgeInsets.only(left:16,right:16),
                          scrollDirection: Axis.vertical,
                          itemCount:3,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // height:74,
                              // width:74,
                              margin:EdgeInsets.only(right:16,bottom:24),
                              child:Row(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:[
                                  Image.asset(
                                    'assets/images/NewsImage.png',
                                    width:134,height:90,
                                  ),
                                  SizedBox(height:10,),
                                  Container(
                                    width:MediaQuery.of(context).size.width-182,
                                    padding:EdgeInsets.only(left:16,right:16),
                                    alignment:Alignment.centerLeft,
                                    child:Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ghost of Tsushima',
                                          // textAlign:TextAlign.center,
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontSize:18,
                                              fontFamily:'OpenSans',
                                              fontWeight:FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(height:10,),
                                        Text(
                                          'The Washington Post Like ‘Ghost of Tsushima’? '
                                              'Here’s what you may not know about samurai. - The Washington ',
                                          textAlign:TextAlign.left,
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontSize:10,
                                              fontFamily:'OpenSans',
                                              fontWeight:FontWeight.normal
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              decoration:BoxDecoration(
                                // color:Colors.red,
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}


