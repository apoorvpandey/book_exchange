import 'package:bookexchange/views/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Engineering",
      "picture": "images/categories/engineering.png",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Bodybuilding",
      "picture": "images/categories/bodybuilding.png",
      "oldPrice": 120,
      "price": 100,
    },
    /*{
      "name": "Career",
      "picture": "images/categories/career.png",
      "oldPrice": 120,
      "price": 100,
    },*/
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
      child: Card(
        child: Hero(
            tag: productName,
            child: Material(
              child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProductDetails())),
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Text(
                          productName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "$productPrice",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "$productOldPrice",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      productPicture,
                      fit: BoxFit.cover,
                    )),
              ),
            )),
      ),
    );
  }
}
