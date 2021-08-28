

import 'package:flutter/material.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';


class ProfileScreen extends StatelessWidget {
  int selectedIndex;
  String strUserName;
  String strMobile;

  List<Map<String, dynamic>> arrInvitedList = [];

  ProfileScreen(this.selectedIndex, this.strUserName, this.strMobile, this.arrInvitedList);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:(selectedIndex == 2) ? true : false,
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
                          'Profile',
                          style:TextStyle(
                              color:HexColor(kMagento),
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
                            'Needs some text for the profile screen, for it to complete 2 lines',
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
                                '@$strUserName',
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
                                strMobile,
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
                    Visibility(
                      visible: (arrInvitedList.length == 0) ? true : true,
                      child: Column(
                        children: [
                          SizedBox(height:24),
                          Text(
                            'All Contacts',
                            style:TextStyle(
                                color:Colors.white,
                                fontSize:14,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w500
                            ),
                          ),
                          SizedBox(height:24),
                          Container(
                            width:MediaQuery.of(context).size.width,
                            height:111,
                            child:ListView.builder(
                                padding:EdgeInsets.only(left:16,right:16),
                                scrollDirection: Axis.horizontal,
                                itemCount: arrInvitedList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height:74,
                                    width:74,
                                    margin:EdgeInsets.only(right:16),
                                    child:ClipRRect(
                                        borderRadius:BorderRadius.circular(37),
                                        child:Column(
                                          children: [
                                            // Image.asset('assets/images/user.png'),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(37),
                                              child: arrInvitedList[index][kProfilePicture].toString().isEmpty
                                                  ? Container(
                                                color: HexColor(kMagento),
                                                height: 74,
                                                width: 74,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  profilePictureEmpty(arrInvitedList[index][kUserName]),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ) : Image.network(
                                                arrInvitedList[index][kProfilePicture].toString(),
                                                fit: BoxFit.fill,
                                                height: 74,
                                                width: 74,
                                              ),
                                            ),
                                            SizedBox(height:10,),
                                            Text(
                                              arrInvitedList[index][kUserName],
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
                        ],
                      ),
                    ),
                    SizedBox(height:60),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}

