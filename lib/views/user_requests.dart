import 'package:bookexchange/database/common.dart';
import 'package:bookexchange/model/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRequests extends StatefulWidget {
  @override
  _UserRequestsState createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  Firestore _firestore = Firestore.instance;


  List<RequestedProduct> requestedProduct = <RequestedProduct>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Requests"),
        ),
        body: ListView.builder(
            itemCount: requestedProduct.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 12.0, 12.0, 6.0),
                              child: Text(
                                requestedProduct[index].requestedProductName,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                requestedProduct[index].userName,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                requestedProduct[index].userEmail,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                requestedProduct[index].mobileNumber,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  )
                ],
              );
            }));
  }

  void getRequestedProductFromDatabase() async {
    List<RequestedProduct> data = await getProducts();
    print("ItemCount " + data.length.toString());
    setState(() {
      requestedProduct = data;
    });
  }

  Future<List<RequestedProduct>> getProducts() =>
      _firestore.collection("requests").where("UserID", isEqualTo: Common.userID).getDocuments().then((snap) {
        List<RequestedProduct> list = [];
        print(snap);
        snap.documents
            .forEach((f) => list.add(RequestedProduct.fromSnapshot(f)));
        return list;
      });

  @override
  void initState() {
    getRequestedProductFromDatabase();
    super.initState();
  }
}
