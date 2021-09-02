

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami/Global/AppUserAuth.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final txtPhoneNumber = TextEditingController();
  final txtInviteCode = TextEditingController();

  List<Map<String, dynamic>> arrAllUserList = [];

  @override
  void initState() {
    super.initState();

    strDialCode = '+91';

    Future.delayed(Duration(microseconds: 100), () {
      getAllUsers();
    });

  }

  getAllUsers() async {
    showLoading(context);

    final snapShot = await FirebaseFirestore.instance.collection(tblUserDetails).get();
    arrAllUserList = snapShot.docs.map((doc) => doc.data()).toList();
    Navigator.pop(context);
  }

  bool isValidInvitationCode() {
    bool isValidInviteCode;

    for(final dictUserDetail in arrAllUserList) {

      if (txtInviteCode.text == dictUserDetail[kInvitationCode].toString()) {
        dictInvitedUser = dictUserDetail;
        isValidInviteCode = true;

        break;
      } else {
        isValidInviteCode = false;
      }

    }

    return isValidInviteCode;
  }

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
                    child: buildSTatusText(),
                  )
              ),
            ),
            SafeArea(
              child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      size: 34,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
              ),
            ),
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
                "Enter your phone number and invite code",
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
                            hintText: 'Phone Number',
                            hintStyle:TextStyle(
                                fontSize:12,
                                fontFamily:'OpenSans',
                                fontWeight:FontWeight.w600
                            ),
                            contentPadding:EdgeInsets.only(left:0,right:10)
                        ),
                      ),
                    )
                  ],
                )
            ),
            SizedBox(height:20,),
            Container(
              height:50,
              margin:EdgeInsets.only(left:40,right:40),
              decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(4)
              ),
              child:TextFormField(
                controller: txtInviteCode,
                keyboardType:TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Invite Code',
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
            SizedBox(height:20,),
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
                    'SIGN UP',
                    style:TextStyle(
                        color:Colors.white,
                        fontSize:16,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w500
                    ),
                  ),
                  onPressed:() {
                    FocusScope.of(context).unfocus();

                    if (txtPhoneNumber.text.isEmpty) {
                      showError(context, 'Enter your phone number');
                    } else if (txtInviteCode.text.isEmpty) {
                      showError(context, 'Enter a invite code');
                    } else if (!isValidInvitationCode())  {
                      showError(context, 'Enter a valid invitation code');
                    } else {
                      isFromSignUp = true;
                      strMobileNumber =  strDialCode+txtPhoneNumber.text;
                      strInvitatedCodeUsed = txtInviteCode.text;
                      getOTP(context);
                    }
                  }),
            ),
          ],
        ),
      );
  }

}
