import 'package:cloud_firestore/cloud_firestore.dart';

class Product{

  static const String BRAND = 'Brand';
  static const String CATEGORY = 'Category';
  static const String PRICE = 'price';

 String _price;
 String _Category;
 String _Brand;

  String get price => _price;

  String get Category => _Category;

  String get Brand => _Brand;

  set Brand(String value) {
    _Brand = value;
  }

  set Category(String value) {
    _Category = value;
  }

  set price(String value) {
    _price = value;
  }


  Product.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _price = data[PRICE];
    _Brand = data[BRAND];
    _Category = data[CATEGORY];

  }

}