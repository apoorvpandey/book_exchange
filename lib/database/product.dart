import 'package:bookexchange/database/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;

  void uploadProduct({String productName, String brand, String category, int quantity, List images, String price}){
    var id = Uuid();
    String productId = id.v1();

    bool approved = false;

    _firestore.collection("productsAddedByUser").document(productId).setData({
      "addedByUserEmail": Common.userEmail,
      "addedByUserName": Common.userName,
      "addedByUserPhone": Common.mobileNumber,
      "addedByUserId": Common.userID,
      "name": productName,
      "Id": productId,
      "Brand": brand,
      "Category": category,
      "price": price,
      "imageUrl": images,
      "isApproved": approved
    });
  }


}
