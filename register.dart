//import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/auth_service/auth_service.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newDateofbirth = TextEditingController();
  TextEditingController newIdNumber = TextEditingController();
  TextEditingController newContactNumber = TextEditingController();
  final _auth = AuthService();
  final firestoreUser = FirebaseFirestore.instance.collection("users");
  final firestoreAdmin = FirebaseFirestore.instance.collection("admin");
  String? portal = "User";
  List<String> times = [
    "Admin",
    "User",
  ];
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    newEmailController.dispose();
    newPasswordController.dispose();
    newDateofbirth.dispose();
    newIdNumber.dispose();
    newContactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text(
          "HOSPITAL MANAGEMENT APP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(135, 171, 255, 1),
                  Color.fromARGB(255, 15, 59, 192)
                ],
                stops: [
                  0.1,
                  0.92
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Are you signing up in as: ",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: const Color.fromARGB(255, 29, 54, 193),
                          ),
                          child: DropdownButton(
                            hint: const Text("User",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
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
                    const SizedBox(height: 12),
                    //------------------------------TITLE TEXT------------------------------------------------------------
                    const Text("Register",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    //---------------------------FIRST NAME TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: firstNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'First Name',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),

                    //FIRST NAME TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'Last Name',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),

                    //EMAIL TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: newEmailController,
                          keyboardType: TextInputType.emailAddress,
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
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'Email Address',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),
                    //PASSWORD TEXTFIELD---------------------------------------------------

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
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
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
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

                    //DATE OF BIRTH TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: newDateofbirth,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your date of birth";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'Date of Birth',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),

                    //ID NUMBER TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: newIdNumber,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your ID number";
                            } else if (value.length < 13 || value.length > 13) {
                              return "ID number cannot be less or more than 13 digits";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'ID Number',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),

                    //CONTACT NUMBER TEXTFIELD---------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, value, child) => TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: newContactNumber,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your contact number";
                            } else if (value.length < 10 || value.length > 10) {
                              return "Contact number cannot be less than 10 digits";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 29, 54, 193),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 62, 87, 228)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              labelText: 'Contact Number',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 57, 83, 228),
                        minimumSize: const Size(200, 45),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<AppProvider>()
                              .changeUserName(newEmailController.text);
                          _register();
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    //SIGN IN SECTION---------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                            style: TextStyle(color: Colors.white)),
                        InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteManager.loginPage),
                          child: Text(
                            " Login",
                            style: TextStyle(color: Colors.blue[200]),
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
      ),
    );
  }

  ///register method is the same as yours, I just used the User class instead of final keyword.
  ///Also put method at the end of the code, not at the beginning. I'm not sure if it has any impact
  ///but it's easier to keep track of (for me)
  void _register() async {
    User? user = await _auth.createUserWithEmailAndPassword(
        newEmailController.text, newPasswordController.text);

    if (user != null) {
      if (portal == "User") {
        String id = firestoreUser.doc().id;
        await firestoreUser.doc(id).set(
          {
            "first name": firstNameController.text,
            "last name": lastNameController.text,
            "username": newEmailController.text,
            "password": newPasswordController.text,
            "date of birth": newDateofbirth.text,
            "id number": newIdNumber.text,
            "contact number": newContactNumber.text,
            "id": id
          },
        );
        _goToMainPage();
      } else if (portal == "Admin") {
        String id = firestoreAdmin.doc().id;
        await firestoreAdmin.doc(id).set(
          {
            "first name": firstNameController.text,
            "last name": lastNameController.text,
            "username": newEmailController.text,
            "password": newPasswordController.text,
            "date of birth": newDateofbirth.text,
            "id number": newIdNumber.text,
            "contact number": newContactNumber.text,
            "id": id
          },
        );

        _goToAdminPage();
      }
    }

    /*else if (portal == null) {
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
          content:
              const Text("You must specify whether you're a user or an admin"),
        ),
      );
    }*/
  }

  ///navigate back to main page
  _goToMainPage() {
    Navigator.of(context).pushNamed(RouteManager.mainPage);
  }

  _goToAdminPage() {
    Navigator.of(context).pushNamed(RouteManager.adminPage);
  }
}
