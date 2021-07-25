

import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  double zoomScale = 1.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation:0,
        centerTitle:true,
        backgroundColor: Colors.transparent,
        brightness:Brightness.dark,
        title:Image.asset(
          'assets/images/LOGO.png',
          width:MediaQuery.of(context).size.width-(145*2),
          fit:BoxFit.fill,
          // fit:BoxFit.fitWidth,
        ),
      ),
      backgroundColor:HexColor(
          kThemeColor
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          padding:EdgeInsets.only(bottom:40),
          child:Column(
            children: [
              SizedBox(height:30,),
              /*Image.asset(
                'assets/images/white-blue_TEXT.png',
                width:MediaQuery.of(context).size.width-(80*2),
                fit:BoxFit.fill,
              ),*/
              Icon(Icons.account_circle, size: MediaQuery.of(context).size.width/2, color: Colors.white,),

              SizedBox(height:44,),

              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(

                  keyboardType:TextInputType.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Full Name',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:16,),
              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Email Address',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:16,),
              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(
                  obscureText:true,
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Email Address',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:16,),
              Container(
                height:50,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(4)
                ),
                child:TextFormField(
                  keyboardType:TextInputType.phone,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                      hintText: 'Mobile Number',
                      hintStyle:TextStyle(
                        // color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w600
                      ),
                      contentPadding:EdgeInsets.only(left:10,right:10)
                    // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                  ),
                ),
              ),
              SizedBox(height:60,),
              Container(
                  height:50,
                  width: double.infinity,
                  margin:EdgeInsets.only(left:40,right:40),
                  decoration:BoxDecoration(
                    color:Colors.white,
                      borderRadius:BorderRadius.circular(4)
                  ),
                  child:TextButton(
                      child:Text(
                        'Update',
                        style:TextStyle(
                            color:Colors.black,
                            fontSize:16,
                            fontFamily:'OpenSans',
                            fontWeight:FontWeight.bold
                        ),
                      ),
                      onPressed:() {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Tabbar()),
                        // );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


