import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  var productsInTheCart = [
    {
      "name": "Engineering",
      "picture": "assets/images/categories/engineering.png",
      "price": 100,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Bodybuilding",
      "picture": "assets/images/categories/bodybuilding.png",
      "price": 150,
      "size": "S",
      "color": "White",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsInTheCart.length,
        itemBuilder: (context, index){
        return SingleCartProduct(
          cartProductName: productsInTheCart[index] ["name"],
          cartProductColor: productsInTheCart[index] ["color"],
          cartProductPicture: productsInTheCart[index] ["picture"],
          cartProductPrice: productsInTheCart[index] ["price"],
          cartProductQuantity: productsInTheCart[index] ["quantity"],
          cartProductSize: productsInTheCart[index] ["size"],
        );
        });

  }
}

class SingleCartProduct extends StatelessWidget {

  final cartProductName, cartProductPicture, cartProductPrice, cartProductSize, cartProductColor, cartProductQuantity;


  SingleCartProduct({
      this.cartProductName,
      this.cartProductPicture,
      this.cartProductPrice,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cartProductPicture, width: 80 , height: 80,),
        title: Text(cartProductName),
        subtitle: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text("Size:", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cartProductSize, style: TextStyle(fontStyle: FontStyle.italic)),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Text("Color:", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cartProductColor, style: TextStyle(fontStyle: FontStyle.italic),),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text("Price:", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("₹"+"${cartProductPrice}", style: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}

