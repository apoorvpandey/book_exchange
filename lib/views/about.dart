import 'package:bookexchange/database/common.dart';
import 'package:flutter/material.dart';
import 'stackedIcons.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("About Book Exchange"),
      ),
      body: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new StackedIcons(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        child: new Text(
                          "Book Exchange",
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 32.0),
                        ),
                      ),
                    ),
                    Image.asset("images/illustration_white.jpg", width: MediaQuery.of(context).size.width, height: 256,),
                  ],
                )


              ],
            ),
          ],
        ),
      ),
    );
  }
}
