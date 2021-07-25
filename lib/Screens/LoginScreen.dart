

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';
import 'package:gami/Global/AppUserAuth.dart';
import 'package:country_code_picker/country_code_picker.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final txtPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                height: size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HexColor(kThemeColor),
                        HexColor(kThemeColor2),
                      ],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                    )
                ),
                child: Center(
                  child:
                  buildSTatusText(),
                )

            ),
          ),
          SafeArea(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      )
    );
  }

  Widget buildSTatusText()
  {
    return
      Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage(
                  'assets/images/onboarding01.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 90,
              child: Text(
                "Enter your phone number and password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: HexColor(kMagento),
                    fontSize:27,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height:20,),
            Container(
              height:50,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(4)
              ),
              child: Row(
                children: [
                  Container(
                    // color: Colors.red,
                    width: 60,
                    child: CountryCodePicker(
                      onChanged: (value) {
                        strDialCode = value.dialCode;
                      },
                      // backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,

                      initialSelection: 'IN',
                      showCountryOnly: true,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      showFlag: false,

                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: txtPhoneNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                          hintText: 'Phone Number',
                          hintStyle:TextStyle(
                            // color:Colors.white,
                              fontSize:12,
                              fontFamily:'OpenSans',
                              fontWeight:FontWeight.w600
                          ),
                          contentPadding:EdgeInsets.only(left:0,right:10)
                        // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      ),
                    ),
                  )
                ],
              )
            ),
            SizedBox(height:20,),
            // Container(
            //   height:50,
            //   margin:EdgeInsets.only(left:40,right:40),
            //   decoration:BoxDecoration(
            //       color:Colors.white,
            //       borderRadius:BorderRadius.circular(4)
            //   ),
            //   child:TextFormField(
            //     obscureText: true,
            //     keyboardType:TextInputType.name,
            //     decoration: InputDecoration(
            //         border: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         enabledBorder: InputBorder.none,
            //         errorBorder: InputBorder.none,
            //         disabledBorder: InputBorder.none,
            //         // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
            //         hintText: 'Password',
            //
            //         hintStyle:TextStyle(
            //           // color:Colors.white,
            //             fontSize:12,
            //             fontFamily:'OpenSans',
            //             fontWeight:FontWeight.w600
            //         ),
            //         contentPadding:EdgeInsets.only(left:10,right:10)
            //       // EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            //     ),
            //   ),
            // ),
            // SizedBox(height:20,),
            Container(
              height:50,
              width: double.infinity,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color: HexColor(kMagento),
                  borderRadius:BorderRadius.circular(12)
              ),
              child:TextButton(
                  child:Text(
                    'LOGIN',
                    style:TextStyle(
                        color:Colors.white,
                        fontSize:16,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w500
                    ),
                  ),
                  onPressed:() {
                    isFromSignUp = false;

                    if (txtPhoneNumber.text.isEmpty) {
                      shwoError(context, 'Enter your phone number');
                    } else {
                      isFromSignUp = false;
                      strMobileNumber = strDialCode+txtPhoneNumber.text;
                      getOTP(context);
                    }
                  }),
            ),
          ],
        ),
      );
  }
}
