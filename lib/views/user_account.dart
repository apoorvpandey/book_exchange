import 'package:bookexchange/model/user_model.dart';
import 'package:bookexchange/views/home.dart';
import 'package:flutter/material.dart';
import 'package:bookexchange/database/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _mobileNumberTextEditingController =
      new TextEditingController();
  TextEditingController _addressTextEditingController =
      new TextEditingController();

  @override
  void initState() {
    _mobileNumberTextEditingController = TextEditingController(
        text: (Common.mobileNumber == null ? "" : Common.mobileNumber));
    _addressTextEditingController = TextEditingController(
        text: (Common.address == null ? "" : Common.address));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(Common.userProfilePicture),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(64, 16.0, 64, 16),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          (Common.userName == null ? "" : Common.userName),
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFFA9A9A9))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(64, 16.0, 64, 16),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (Common.userEmail == null ? "" : Common.userEmail),
                        style: TextStyle(
                            fontSize: 16, color: Color(0xFFA9A9A9)),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(64, 16, 64, 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller:
                                    _mobileNumberTextEditingController,
                                validator: (val) {
                                  if (val.length < 10 || val.isEmpty) {
                                    return "Please enter correct mobile number";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    hintText: "Enter your mobile number"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: 250,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _addressTextEditingController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Address can not be empty";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.streetAddress,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    hintText:
                                        "Enter your delivery address"),
                              ),
                            ),
                          ),
                          MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  updateProfile();
                                }
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("Update your profile")),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() {
    Firestore.instance.collection("Users").document(Common.userID).setData({
      "ID": Common.userID,
      "userName": Common.userName,
      "profilePicture": Common.userProfilePicture,
      "userEmail": Common.userEmail,
      "mobileNumber": _mobileNumberTextEditingController.text,
      "address": _addressTextEditingController.text,
    });

    Fluttertoast.showToast(
        backgroundColor: Colors.black, msg: "Profile updated!");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
