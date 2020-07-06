import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Blazer",
      "picture": "images/categories",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Bodybuilding",
      "picture": "images/categories/bodybuilding.jpg",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Career",
      "picture": "images/categories/career.png",
      "oldPrice": 120,
      "price": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productName: productList[index]["name"],
            productPicture: productList[index]["picture"],
            productOldPrice: productList[index]["oldPrice"],
            productPrice: productList[index]["price"],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final productName, productPicture, productOldPrice, productPrice;

  SingleProduct(
      {this.productName,
      this.productOldPrice,
      this.productPicture,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("test")
    );
  }
}
