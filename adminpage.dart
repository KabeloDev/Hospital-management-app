// ignore_for_file: file_names

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:hospital_management_app/provider/provider.dart";
import "package:hospital_management_app/routes/routes.dart";
import "package:provider/provider.dart";

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _MainPageState();
}

class _MainPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text(
          "ADMIN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //header------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi There,",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Consumer<AppProvider>(
                          builder: (context, value, child) => Text(
                            value.userName.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Appointments Information bar----------------------------

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouteManager.userListPage),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(135, 171, 255, 1),
                            Color.fromARGB(255, 42, 94, 248)
                          ],
                          stops: [
                            0.1,
                            0.92
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color.fromARGB(255, 42, 94, 248),
                                  Color.fromRGBO(135, 171, 255, 1)
                                ],
                                stops: [
                                  0.1,
                                  0.92
                                ]),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.verified_user,
                          size: 75,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Users List\n(Click Here)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Book an Appointment & Review Page----------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(RouteManager.apptListPage),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.43,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 94, 248),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Appointment",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("List",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(RouteManager.revListPage),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.43,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 94, 248),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Review",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("List",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 12),
            //LOGOUT/SIGNOUT BUTTON--------------------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 29, 54, 193),
                    minimumSize: const Size(415, 65),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamed(RouteManager.loginPage);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
