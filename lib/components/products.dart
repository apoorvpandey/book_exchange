import 'package:bookexchange/model/product_model.dart';
import 'package:bookexchange/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  Firestore _firestore = Firestore.instance;
  List<Product> products = <Product>[];

/*  var productList = [
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
    {
      "name": "Security",
      "picture": "images/categories/security.png",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Influencing",
      "picture": "images/categories/influencing.png",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Electronics",
      "picture": "images/categories/electronics.png",
      "oldPrice": 120,
      "price": 100,
    },
    {
      "name": "Cloud Computing",
      "picture": "assets/images/categories/cloud.png",
      "oldPrice": 120,
      "price": 100,
    },
  ];*/

  @override
  void initState() {
    getProductsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productName: products[index].name,
            productPicture: products[index].Category,
            // productOldPrice: products[index]["Brand"],
            productPrice: products[index].price,
          );
        });
  }

  void getProductsFromFirebase() async {
      List<Product> data = await getProducts();
      print("ItemCount "+data.length.toString());

      setState(() {
        products = data;
        // categoriesDropDown = getCategoriesDropDown();
       // productList = products[0].data["products"];
      });
    }

  Future <List<Product>> getProducts()=>
      _firestore.collection("products").getDocuments().then((snap) {

        List<Product> list = [];

       // snap.documents.map((e) => list.add(Product.fromSnapshot(e)));
      //  snap.documents.forEach((f) => print('${f.data}}'));
        snap.documents.forEach((f) =>  list.add(Product.fromSnapshot(f)));
        return list;
      });

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
            tag: Text("Hero"),
            child: Material(
              child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new ProductDetails(
                          productDetailsName: productName,
                          productDetailsNewPrice: productPrice,
                          productDetailsOldPrice: productOldPrice,
                          productDetailsPicture: productPicture,
                        ))),
                child: GridTile(
                    footer: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Text(
                              "₹${productPrice}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
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
