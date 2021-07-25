import 'package:flutter/material.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';

class TransactionScreen extends StatelessWidget{

  int selectedIndex;
  TransactionScreen(this.selectedIndex);

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible:(selectedIndex == 4) ? true : false,
      child:Positioned(
          left:0,right:0,top: 0,bottom: 0,
          child:Stack(
            children:[
              Positioned(
                left:0,right: 0,bottom: 0,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      width:(MediaQuery.of(context).size.width-120)/2,
                      child:FittedBox(
                        fit: BoxFit.fill,
                        child:Text(
                          'Transactions',
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
                        width:MediaQuery.of(context).size.width-90,
                        child:SizedBox(
                          child:Text(
                            'Need some text for the profile screen, for it to complete 2 lines',
                            style:TextStyle(
                              color:Colors.white,
                              // fontSize:15,
                              fontFamily:'OpenSans',
                              fontWeight:FontWeight.w600,

                            ),
                          ),
                        )
                    ),
                    SizedBox(height:24),
                    Container(
                      height:46,
                      width:MediaQuery.of(context).size.width-120,
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            // Icons.facebook_sharp,
                            Icons.face,
                            color: Colors.white,
                            size: 30,
                          ),
                          Icon(
                            // Icons.facebook_sharp,
                            Icons.face,
                            color: Colors.white,
                            size: 30,
                          ),

                          Icon(
                            // Icons.facebook_sharp,
                            Icons.face,
                            color: Colors.white,
                            size: 30,
                          ),

                          Icon(
                            // Icons.facebook_sharp,
                            Icons.face,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),

                    ),
                    SizedBox(height:24),
                    Container(
                      height:46,
                      width:MediaQuery.of(context).size.width-90,
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
                                '@AZAD.UDDIN',
                                style:TextStyle(
                                    color:Colors.black,
                                    fontSize:14,
                                    fontFamily:'OpenSans',
                                    fontWeight:FontWeight.w500
                                ),
                              ),
                              Text(
                                'Username',
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
                      width:MediaQuery.of(context).size.width-90,
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
                                '07415-4567-7891',
                                style:TextStyle(
                                    color:Colors.black,
                                    fontSize:14,
                                    fontFamily:'OpenSans',
                                    fontWeight:FontWeight.w500
                                ),
                              ),
                              Text(
                                'Mobile',
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
                      width:MediaQuery.of(context).size.width-90,
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


                    SizedBox(
                      height:MediaQuery
                          .of(context)
                          .padding
                          .bottom+130,
                    ),




                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}