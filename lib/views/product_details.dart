import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final productDetailsName;
  final productDetailsNewPrice;
  final productDetailsOldPrice;
  final productDetailsPicture;
  final productDetailsBrand;

  ProductDetails(
      {this.productDetailsName,
      this.productDetailsNewPrice,
      this.productDetailsOldPrice,
      this.productDetailsBrand,
      this.productDetailsPicture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("View Product Details"),
        actions: [
         /* IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),*/
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.productDetailsPicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailsName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "₹${widget.productDetailsNewPrice}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              /*Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: Text("Size"),
                            content: Text("Choose your desired size"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black54,
                  child: Row(
                    children: [
                      Expanded(child: Text("Size")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),*/
              /*Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: Text("Color"),
                            content: Text("Choose your desired color"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black54,
                  child: Row(
                    children: [
                      Expanded(child: Text("Color")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),*/
              /*Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: Text("Quantity"),
                            content: Text("Choose the quantity"),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black54,
                  child: Row(
                    children: [
                      Expanded(child: Text("Qty")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8
                  ),
                  child: MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Buy now")),
                ),
              ),
              /*IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {}),*/
            ],
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text("Product details"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset"),
          ),
          Divider(color: Colors.grey),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.productDetailsName),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.productDetailsBrand),
              )
            ],
          ),
          /*Divider(),
          Text("Similar products"),
          Padding(padding: EdgeInsets.all(5)),
          Container(
            height: 360,
            child: SimilarProducts(),
          )*/
        ],
      ),
    );
  }
}

/*class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
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
      "picture": "images/categories/cloud.png",
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
          return SimilarSingleProduct(
            productName: productList[index]["name"],
            productPicture: productList[index]["picture"],
//            productOldPrice: productList[index]["oldPrice"],
            productPrice: productList[index]["price"],
          );
        });
  }
}*/

class SimilarSingleProduct extends StatelessWidget {
  final productName, productPicture, productOldPrice, productPrice;

  SimilarSingleProduct(
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
