import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/users.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  TextEditingController _nameTextController = new TextEditingController();
  UserServices _userServices = UserServices();
  String gender;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
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
                                          hintText: "Full Name",
                                          icon: Icon(Icons.person),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "The Full Name can not be empty";
                                          } else if (value.length < 3) {
                                            return "The password has to be at least 3 characters long";
                                          }
                                        },
                                        controller: _nameTextController,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "The Password can not be empty";
                                          } else if (value.length < 6) {
                                            return "The password has to be at least 6 characters long";
                                          }
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
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "The Password can not be empty";
                                          } else if (value.length < 6) {
                                            return "The password has to be at least 6 characters long";
                                          } else if (_passwordTextController
                                                  .text !=
                                              value) {
                                            return "The password do not match";
                                          }
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
                                          hintText: "Confirm password",
                                          icon: Icon(Icons.lock),
                                        ),
                                        controller: _passwordTextController,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  validateUser();
                                },
                                child: Container(
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
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                              ),
                              // Password Field End
                              Container(
                                margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
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

  void validateUser() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth

            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser(user.user.uid, {
                    "userName": user.user.displayName,
                    "email": user.user.email,
                    "userId": user.user.uid,
                  })
                });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
