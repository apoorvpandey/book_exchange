import 'package:bookexchange/components/horizontal_list_view.dart';
import 'package:bookexchange/components/products.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Widget imageCarousel = new Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/carousel/image1.jpg"),
          AssetImage("images/carousel/image2.jpg"),
          AssetImage("images/carousel/image3.jpg"),
          AssetImage("images/carousel/image4.jpg"),
        ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4,
        indicatorBgPadding: 2,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Homepage"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: Text("Apoorv Pandey"),
                accountEmail: Text("apoorvpandey111@gmail.com"),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
              decoration: new BoxDecoration(
                color: Colors.redAccent
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_basket, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Categories"),
                leading: Icon(Icons.category, color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Favorites"),
                leading: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings, color: Colors.black54,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.info, color: Colors.blue,),
              ),
            ),

          ],
        ),
      ),

      body: new ListView(
        children: [
          imageCarousel,
          new Padding(padding: const EdgeInsets.all(8),
          child: Text("Categories"),),

      HorizontalListView(),

          new Padding(padding: const EdgeInsets.all(20),
            child: Text("Recent products"),),

          Container(
            height: 320,
            child: Products(),
          )

        ],
      ),

    );
  }
}
