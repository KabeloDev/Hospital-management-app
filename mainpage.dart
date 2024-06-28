// ignore_for_file: file_names

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:hospital_management_app/provider/provider.dart";
import "package:hospital_management_app/routes/routes.dart";
import "package:provider/provider.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                  //LOGO---------------------------------------------------------

                  //My Profile--------------------------------------
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RouteManager.myProfile),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 42, 94, 248),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Row(children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text("My Profile Page",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 5),
                      ]),
                    ),
                  )
                ],
              ),
            ),

            //Appointments Information bar----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                          Icons.calendar_month_outlined,
                          size: 75,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<AppProvider>(
                              builder: (context, value, child) => const Text(
                                  "You Have Appointments on the following days:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            const SizedBox(height: 8),
                            Consumer<AppProvider>(
                              builder: (context, value, child) => Text(
                                "Date: ${value.apptDate} | Time: ${value.apptTime}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
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
                          .pushNamed(RouteManager.appointments),
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
                                Text("Book",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Appointment",
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
                          .pushNamed(RouteManager.reviewPage),
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
                                Text("Page",
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
            //Hospital ads-----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Sunshine!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Enjoying some sunshine in the mornings may help\nyou lose weight"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(
                            Icons.sunny,
                            size: 40,
                            color: Colors.orange[100],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Sunshine",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Bananas!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Bananas can help improve your mood."))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.healing_outlined,
                              size: 40, color: Colors.yellow[900]),
                          const SizedBox(width: 5),
                          Text(
                            "Bananas",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[900]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Sleep!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Lack of sleep can kill someone\nSooner than starvation"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.night_shelter,
                              size: 40, color: Colors.purple[100]),
                          const SizedBox(width: 5),
                          Text(
                            "Sleep",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Breakfast"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Breakfast is the most important meal of the day\nbecause it feeds your body and mind\nwith the necessary nutrients"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.sunny_snowing,
                              size: 40, color: Colors.orange[100]),
                          const SizedBox(width: 5),
                          Text(
                            "Breakfast",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Exercise!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Exercising when you are younger improves brain functioning\nas you get older"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.run_circle_outlined,
                              size: 40, color: Colors.blue[100]),
                          const SizedBox(width: 5),
                          Text(
                            "Exercise",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Tea!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Research suggests that plant compounds in tea may play\n a role in reducing your risk of chronic conditions\nsuch as cancer & heart dsease"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.coffee,
                              size: 40, color: Colors.green[200]),
                          const SizedBox(width: 5),
                          Text(
                            "Tea",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[200]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Sugar!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Reducing your daily intake of sugar may help with losing weight and a big tummy"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.food_bank_outlined,
                              size: 40, color: Colors.purple[100]),
                          const SizedBox(width: 5),
                          Text(
                            "Sugar",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Water!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Not only does water regulate body temperature but it also boosts skin health and beauty"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.water_drop_outlined,
                              size: 40, color: Colors.blue[100]),
                          const SizedBox(width: 5),
                          Text(
                            "Water",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[100]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("close")),
                                  ],
                                  title: const Text("Eggs!"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: const Text(
                                      "Help Boost Nutrient Intake for Healthy Aging"))),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          Icon(Icons.egg_alt,
                              size: 40, color: Colors.yellow[900]),
                          const SizedBox(width: 5),
                          Text(
                            "Eggs",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[900]),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),

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
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                    ),
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
