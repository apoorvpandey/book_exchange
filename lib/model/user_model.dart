import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const String USERNAME = 'userName';
  static const String USERID = 'ID';
  static const String ADDRESS = 'address';
  static const String MOBILENUMBER = 'mobileNumber';
  static const String PROFILEPICTURE = 'profilePicture';
  static const String EMAILADDRESS = 'userEmail';

  String _UserName;
  String _ID;
  String _address;
  String _mobileNumber;
  String _profilePicture;
  String _userEmail;

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get UserName => _UserName;

  set UserName(String value) {
    _UserName = value;
  }

  String get ID => _ID;

  String get profilePicture => _profilePicture;

  set profilePicture(String value) {
    _profilePicture = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  set ID(String value) {
    _ID = value;
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _UserName = data[USERNAME];
    _ID = data[USERID];
    _address = data[ADDRESS];
    _mobileNumber = data[MOBILENUMBER];
    _profilePicture =data[PROFILEPICTURE];
    _userEmail =data[EMAILADDRESS];
  }


}
