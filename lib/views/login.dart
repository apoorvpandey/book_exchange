import 'package:bookexchange/views/signup.dart';
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
    FirebaseUser user = await firebaseAuth.currentUser().then((user){
      if(user!=null)
        {
          setState(() => isLoggedIn = true);
        }
    });
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
      body: SingleChildScrollView(
        child: Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/background.jpg",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  color: Colors.black.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
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
                              Container(
                                margin: EdgeInsets.only(bottom: 32),
                                height: 54,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white.withOpacity(0.5),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0)),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0)),
                                          ),
                                          hintText: "Email",
                                          icon: Icon(Icons.email),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                              ),
                              // Email Field End //
                              // Password Field Start
                              Container(
                                margin: EdgeInsets.only(bottom: 32),
                                height: 54,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white.withOpacity(0.5),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (val) {
                                          return val.length > 6
                                              ? null
                                              : "Password must be at least char";
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0)),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0)),
                                          ),
                                          hintText: "Password",
                                          icon: Icon(Icons.lock),
                                        ),
                                        controller: _passwordTextController,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(64, 0, 64, 18),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ),
                              // Password Field End

                              Container(
                                  margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                                  child: Divider(color: Colors.grey)),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
                                child: Text(
                                  "Other login option",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleSign();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(64, 0, 64, 18),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Login with Google",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 8, 0, 16),
                                  child: Text(
                                    "Not registered? Click here to sign up",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                              ),
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
          ),
        ),
      ),
    );
  }
}
