

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  List<Map<String, dynamic>> arrTransactions = [];
  String strTotal = '0';

  getTransactionsList() async {
    showLoading(context);
    final querySnapShot = await FirebaseFirestore.instance
        .collection(tblTransactions)
        .doc(strInvitationCode)
        .collection(strInvitationCode)
        .orderBy(kID, descending: true)
        .get();

    arrTransactions = querySnapShot.docs.map((docInMapFormat) {
      return docInMapFormat.data();
    }).toList();

    for (final dict in arrTransactions) {
      final strAttention = int.parse(dict['attention'].toString());
      final strInvite = int.parse(dict['invite'].toString());
      final strMining = int.parse(dict['mining'].toString());

      strTotal = (int.parse(strTotal)+strAttention+strInvite+strMining).toString();
    }

    setState(() {

    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(microseconds: 100), () {
      getTransactionsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      backgroundColor: HexColor('#FA136F'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: Colors.white,
                ),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  width: 40,
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                )
              ),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arrTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  String strDate = arrTransactions[index][kCreatedTime].toString();
                  String strToday = DateFormat('dd MMM yyyy').format(DateTime.now());
                  // hello
                  String strYesterday = DateFormat('dd MMM yyyy').format(
                      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)
                  );

                  if (strDate == strToday) {
                    strDate = 'Today';
                  } else if (strDate == strYesterday) {
                    strDate = 'Yesterday';
                  } else {
                    strDate = strDate;
                  }

                  return Container(
                    padding: EdgeInsets.only(
                      top: (index == 0) ? 30 : 0,
                      bottom: 30,
                      left: 22, right: 22,
                    ),
                    child: Column(
                      children: [
                        (index == 0)
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '\$'+strTotal,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: HexColor('#FA136F'),
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: HexColor('#CECECE'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 22,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/miningTransaction.svg',
                                  height:40,
                                ),
                                SizedBox(width: 16,),
                                Text(
                                  'Mining',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '+\$' + arrTransactions[index]['mining'].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/attentionTransaction.svg',
                                  height:40,
                                ),
                                SizedBox(width: 16,),
                                Text(
                                  'Attention',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '+\$' + arrTransactions[index]['attention'].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/inviteTransaction.svg',
                                  height:40,
                                ),
                                SizedBox(width: 16,),
                                Text(
                                  'Invite',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '+\$' + arrTransactions[index]['invite'].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

