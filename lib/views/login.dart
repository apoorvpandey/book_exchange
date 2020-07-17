import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSign() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    if (credential != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("Users")
          .where("ID", isEqualTo: googleUser.id)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance
            .collection("Users")
            .document(googleUser.id)
            .setData({
          "ID": googleUser.id,
          "userName": googleUser.displayName,
          "profilePicture": googleUser.photoUrl,
        });
        await preferences.setString("ID", googleUser.id);
        await preferences.setString("userName", googleUser.displayName);
        await preferences.setString("profilePicture", googleUser.photoUrl);
      }

      else
        {
          await preferences.setString("ID", documents[0]["ID"]);
          await preferences.setString("userName", documents[0]["userName"]);
          await preferences.setString("profilePicture", documents[0]["profilePicture"]);
        }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sign in successful!"),
      ));
      setState(() {
        loading = false;
      });

    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: () {
                isSignedIn();
              },
              child: Text(
                'SignIn/SignUp with Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Visibility(
            // visible: loading ?? true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

