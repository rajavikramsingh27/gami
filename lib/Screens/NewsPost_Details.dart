
import 'package:flutter/material.dart';
import 'package:gami/Constant/Constant.dart';
import 'package:gami/Global/Global.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsPostDetails extends StatefulWidget {
  Map<String, dynamic> dictNewsPosts = {

  };

  NewsPostDetails(this.dictNewsPosts);

  @override
  _NewsPostDetailsState createState() => _NewsPostDetailsState();
}

class _NewsPostDetailsState extends State<NewsPostDetails> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(
        kThemeColor
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: 20
            ),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      getImage(widget.dictNewsPosts),
                      // height: 340,
                      // fit: BoxFit.cover,
                      // 'https://gami.me/wp-content/uploads/'+Map<String, dynamic>.from(arrNewsPosts[index]['media_details'])['file'],
                    )
                ),
                SizedBox(height:10,),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Text(
                    Map<String, dynamic>.from(widget.dictNewsPosts['title'])["rendered"],
                    // textAlign:TextAlign.center,
                    style:TextStyle(
                        color:Colors.white,
                        fontSize:20,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.w600
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Html(
                    data: Map<String, dynamic>.from(widget.dictNewsPosts['content'])["rendered"],
                    defaultTextStyle: TextStyle(
                        color:Colors.white,
                        fontSize:12,
                        fontFamily:'OpenSans',
                        fontWeight:FontWeight.normal
                    ),
                    // padding: EdgeInsets.all(8.0),
                    // onLinkTap: (url) {
                    //   print("Opening $url...");
                    // },
                    // customRender: (node, children) {
                    //   if (node is dom.Element) {
                    //     switch (node.localName) {
                    //       case "custom_tag": // using this, you can handle custom tags in your HTML
                    //         return Column(children: children);
                    //     }
                    //   }
                    // },
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
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
          )
        ],
      )
    );
  }
}
