import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:hospital_management_app/auth_service/auth_service.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  //final _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String result = " ";
  bool isLoading = false;
  User? googleUser;
  String? portal;
  List<String> times = [
    "Admin",
    "User",
  ];
  int usernameCounterAdmin = 0;
  int passwordCounterAdmin = 0;

  int usernameCounterUser = 0;
  int passwordCounterUser = 0;

  var adminCollection = FirebaseFirestore.instance.collection("admin");
  var userCollection = FirebaseFirestore.instance.collection("users");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "HOSPITAL MANAGEMENT APP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),*/
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/036/222/149/large_2x/ai-generated-team-of-doctor-in-a-hospital-background-hospital-medical-team-banner-with-group-of-smiling-healthy-doctors-and-nurses-ai-generated-free-photo.jpg'),
              fit: BoxFit.cover,
            ),
            /*gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(135, 171, 255, 1),
                  Color.fromARGB(255, 15, 59, 192)
                ],
                stops: [
                  0.1,
                  0.92
                ]),*/
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //-------------------Selection Portal------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign in as: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: const Color.fromARGB(255, 29, 54, 193),
                        ),
                        child: DropdownButton(
                          hint: const Text("Select Portal",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          value: portal,
                          onChanged: (newTime) {
                            setState(() {
                              portal = newTime.toString();
                            });
                          },
                          items: times.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //----------------------------Login Header--------------------------
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  //-----------------------------EMAIL TEXTFIELD--------------------------------
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Consumer<AppProvider>(
                      builder: (context, value, child) => TextFormField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          } else if (!value.contains('@')) {
                            return "Email must contain @ symbol";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white60,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: 'Email address',
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  //----------------------------PASSWORD TEXTFIELD--------------------------------
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Consumer<AppProvider>(
                      builder: (context, value, child) => TextFormField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 7) {
                            return "Password needs to be at least 8 characters";
                          } else if (!value.contains('@')) {
                            return "Password must contain @ symbol";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 29, 54, 193),
                      minimumSize: const Size(200, 45),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: //_login,
                        () async {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AppProvider>()
                            .changeUserName(emailController.text);
                        if (portal == "User") {
                          _loginUser();
                        } else if (portal == "Admin") {
                          _loginAdmin();
                        } else if (portal == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ],
                              title: const Text("Select Portal"),
                              contentPadding: const EdgeInsets.all(15),
                              content: const Text(
                                  "You must specify whether you're a user or an admin"),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //-------------------------Sign in with google-------------------------

                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(color: Colors.white)),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(RouteManager.registerPage),
                        child: const Text(
                          " Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 29, 54, 193)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    /*User? user = await _auth.signInUserWithEmailAndPassword(
        emailController.text, passwordController.text);*/

    var num = await userCollection
        .where("username", isEqualTo: emailController.text)
        .get();

    setState(() {
      usernameCounterUser = num.size;
      passwordCounterUser = num.size;
    });

    if (usernameCounterUser == 1 && passwordCounterUser == 1) {
      log('$usernameCounterUser + "|" + $passwordCounterUser');
      log("User logged in Successfully");
      _goToMainPage();
    } else {
      log("$usernameCounterUser | $usernameCounterUser");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ok"),
            ),
          ],
          title: const Text("Unauthorized"),
          contentPadding: const EdgeInsets.all(15),
          content: const Text("You are not registered as a user."),
        ),
      );
      log('$usernameCounterUser + "|" + $passwordCounterUser');
      log("User not signed in");
    }
  }

  void _loginAdmin() async {
    /*User? user = await _auth.signInUserWithEmailAndPassword(
        emailController.text, passwordController.text);*/

    var num = await adminCollection
        .where('username', isEqualTo: emailController.text)
        .get();

    setState(() {
      usernameCounterAdmin = num.size;
      passwordCounterAdmin = num.size;
    });

    if (usernameCounterAdmin == 1 && passwordCounterAdmin == 1) {
      log('$usernameCounterAdmin | $passwordCounterAdmin');
      log("Admin logged in Successfully");
      _goToAdminPage();
    } else {
      log("$usernameCounterUser | $usernameCounterUser");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ok"),
            ),
          ],
          title: const Text("Unauthorized"),
          contentPadding: const EdgeInsets.all(15),
          content: const Text(
              "You are not an admin. Verify that your email and password is correct"),
        ),
      );
      log('$usernameCounterAdmin + "|" + $passwordCounterAdmin');
      log("Admin not signed in");
    }
  }

  _goToMainPage() {
    Navigator.of(context).pushNamed(RouteManager.mainPage);
  }

  _goToAdminPage() {
    Navigator.of(context).pushNamed(RouteManager.adminPage);
  }

  void googleSignIn() {
    if (googleUser != null) {
      context.read<AppProvider>().changeUserName(googleUser?.email.toString());
    } else {
      context.read<AppProvider>().changeUserName("Not working");
    }
  }
}
