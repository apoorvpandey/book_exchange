import 'package:bookexchange/components/products.dart';
import 'package:bookexchange/database/common.dart';
import 'package:bookexchange/model/user_model.dart';
import 'package:bookexchange/views/about.dart';
import 'package:bookexchange/views/add_product.dart';
import 'package:bookexchange/views/login.dart';
import 'package:bookexchange/views/user_account.dart';
import 'package:bookexchange/views/user_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Firestore _firestore = Firestore.instance;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/carousel/product1.jpg"),
          AssetImage("images/carousel/product2.jpg"),
          AssetImage("images/carousel/product3.jpg"),
          AssetImage("images/carousel/product4.jpg"),
        ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4,
        indicatorBgPadding: 2,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Homepage"),
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(Common.userName),
              accountEmail: Text(Common.userEmail),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: NetworkImage(Common.userProfilePicture),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.redAccent),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRequests()));
              },
              child: ListTile(
                title: Text("My Requests"),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(Common.mobileNumber != null && Common.address != null)
                  {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AddProduct()));
                  }
                  else
                    {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.black,
                          msg: "Complete your profile first!");
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => ProfilePage()));
                    }
              },
              child: ListTile(
                title: Text("Add your book"),
                leading: Icon(
                  Icons.add,
                  color: Colors.red,
                ),
              ),
            ),
            /*InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Favorites"),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),*/
            Divider(),
            /* InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ),
            ),*/
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutApp()));
              },
              child: ListTile(
                title: Text("About"),
                leading: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                googleSignOut();
              },
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color(0xffcc0605),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: new Column(
          children: [
            imageCarousel,
            new Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text("Available products"),
            ),
            Container(
              /*height: MediaQuery.of(context).size.height,*/
              /*height: 420,*/
              child: Products(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> googleSignOut() async {
    await _auth.signOut().then((value) {
      _googleSignIn.signOut();
      Common.userID == null;
      Common.userName == null;
      Common.mobileNumber == null;
      Common.address == null;
      Common.userProfilePicture == null;
      setState(() {
        isLoggedIn = false;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    });
  }
@override
  void initState() {
  getUserDetailsFromFirebase();
    super.initState();
  }

  void getUserDetailsFromFirebase() async {
    UserModel userModel = await getUserDetails();

    Common.address = userModel.address;
    Common.mobileNumber = userModel.mobileNumber;


  }

  Future<UserModel> getUserDetails() => _firestore
      .collection("Users")
      .document(Common.userID)
      .get()
      .then((value) => UserModel.fromSnapshot(value));

}
