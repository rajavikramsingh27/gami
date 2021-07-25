
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami/Global/AppUserAuth.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';



class OTP_Screen extends StatefulWidget {
  @override
  _OTP_ScreenState createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {

  final txtOTP = TextEditingController();
  var isResendOTP_ButtonVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    resendOTP_ButtonVisible();
  }

  resendOTP_ButtonVisible() {
    isResendOTP_ButtonVisible = false;

    Future.delayed(Duration(seconds: 60),() {
      isResendOTP_ButtonVisible = true;

      setState(() {

      });
    });


    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor(kThemeColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 34,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "OTP Verification",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize:27,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
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
            // Center(
            //   child: Image(
            //     image: AssetImage(
            //       'assets/images/onboarding01.png',
            //     ),
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            SizedBox(height: 100,),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 90,
              child: Text(
                "We have sent you an SMS to your phone with your confirmation code.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:27,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height:20,),
            Container(
              height:50,
              width: double.infinity,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(4)
              ),
              child: TextFormField(
                controller: txtOTP,
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
                    hintText: 'OTP',
                    hintStyle:TextStyle(
                      // color:Colors.white,
                        fontSize:12,
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
                  color: HexColor(kMagento),
                  borderRadius:BorderRadius.circular(12)
              ),
              child:TextButton(
                  child:Text(
                    'CONFIRM SMS CODE',
                    style:TextStyle(
                        color:Colors.white,
                        fontSize:16,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w500
                    ),
                  ),
                  onPressed:() {

                    if (txtOTP.text.isEmpty) {
                      shwoError(context, 'Enter your OTP.');
                    } else if (txtOTP.text.length < 6) {
                      shwoError(context, 'Enter a valid OTP.');
                    } else {
                      verifyOTP(context, txtOTP.text);
                    }

                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    // Tabbar()), (Route<dynamic> route) => false);
                  }),
            ),
            SizedBox(height:20,),
            Visibility(
              visible: isResendOTP_ButtonVisible,
              child: Container(
                height:50,
                width: double.infinity,
                margin:EdgeInsets.only(left:40,right:40),
                decoration:BoxDecoration(
                    color: HexColor(kMagento),
                    borderRadius:BorderRadius.circular(12)
                ),
                child:TextButton(
                    child:Text(
                      'Resend SMS CODE',
                      style:TextStyle(
                          color:Colors.white,
                          fontSize:16,
                          fontFamily:'OpenSans',
                          fontWeight:FontWeight.w500
                      ),
                    ),
                    onPressed:() {
                      resendOTP_ButtonVisible();
                      resendOTP(context);
                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      // Tabbar()), (Route<dynamic> route) => false);
                    }),
              ),
            )
          ],
        ),
      );
  }


}
