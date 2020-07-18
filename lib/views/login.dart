import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  SharedPreferences preferences;
  final _formKey = GlobalKey<FormState>();
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
        Firestore.instance.collection("Users").document(googleUser.id).setData({
          "ID": googleUser.id,
          "userName": googleUser.displayName,
          "profilePicture": googleUser.photoUrl,
        });
        await preferences.setString("ID", googleUser.id);
        await preferences.setString("userName", googleUser.displayName);
        await preferences.setString("profilePicture", googleUser.photoUrl);
      } else {
        await preferences.setString("ID", documents[0]["ID"]);
        await preferences.setString("userName", documents[0]["userName"]);
        await preferences.setString(
            "profilePicture", documents[0]["profilePicture"]);
      }

      FlutterFlexibleToast.showToast(message: "Sign In Successful");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      setState(() {
        loading = false;
      });
    } else {
      FlutterFlexibleToast.showToast(message: "Sign In Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/background.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Field Start //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:BorderSide(color: Colors.black.withOpacity(0)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black.withOpacity(0)),
                                    ),
                                    hintText: "Email",
                                    icon: Icon(Icons.email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "PLease provide a valid email address";
                                },
                                controller: _emailTextController,
                              ),
                            ),
                          ),
                        ),
                        // Email Field End //
                        // Password Field Start
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                obscureText: true,
                                validator: (val){
                                  return val.length > 6 ? null : "Password must be at least char";
                                },
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:BorderSide(color: Colors.black.withOpacity(0)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0)),
                                  ),
                                  hintText: "Password",
                                  icon: Icon(Icons.lock),
                                ),
                                controller: _passwordTextController,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(32, 18, 32, 18),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xff007ef4),
                                  const Color(0xff2a75bc)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text ("Sign in"),
                        ),
                        // Password Field End
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Colors.red.shade900,
            onPressed: () {
              handleSign();
            },
            child: Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
