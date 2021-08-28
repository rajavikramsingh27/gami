

import 'package:flutter/material.dart';
import 'package:gami/Global/Global.dart';
import '../Constant/Constant.dart';
import '../Global/Global.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gami/Screens/ContactListPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gami/Constant/Constant.dart';
import 'dart:async';


class ShareScreen extends StatelessWidget {

  int selectedIndex;
  String strInvitationCode;

  ShareScreen(this.selectedIndex, this.strInvitationCode);

  Future<void> share() async {
    await FlutterShare.share(
        title: "Gami",
        text: 'Gami',
        linkUrl: 'Here is my invitation link for GAMI App. Use the invitation code: $strInvitationCode. ""Download at $playStoreLink',
        chooserTitle: 'Gami');
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (selectedIndex == 1) ? true : false,
      child: Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Stack(
            children: [
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 120,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'Let\'s Get Started',
                          style: TextStyle(
                              color: HexColor(kMagento),
                              // fontSize:27,
                              fontFamily: 'Rajdhani',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 90,
                        child: SizedBox(
                          child: Text(
                            'Invite your friends to join the GAMI Network with your Innovation code',
                            style: TextStyle(
                                color: Colors.white,
                                // fontSize:15,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 90,
                      padding: EdgeInsets.only(left: 6, right: 7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      child: TextButton(
                          onPressed: () {
                            var invitationLink = "Here is my invitation link for GAMI App. Use the invitation code: $strInvitationCode. "
                                "Download at $playStoreLink";
                            Clipboard.setData(ClipboardData(text: invitationLink));

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:Colors.green,
                                  content:Text(
                                    'Invitation Code is Copied',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 16
                                    ),
                                  ),
                                )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                this.strInvitationCode,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                'Copy',
                                style: TextStyle(
                                    color: HexColor(kMagento),
                                    fontSize: 14,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 90,
                      decoration: BoxDecoration(
                        color: HexColor(kMagento),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (await Permission.contacts.request().isGranted) {

                          }

                          // Map<Permission, PermissionStatus> statuses = await [
                          //   Permission.contacts,
                          // ].request();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactListPage()),
                          );
                        },
                        child: Text(
                          'INVITE YOUR CONTACTS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w500

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white,
                              width: 3
                          )
                      ),
                      child: TextButton(
                        onPressed: () {
                          share();
                        },
                        child: Text(
                          'SHARE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .padding
                          .bottom + 130,
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

