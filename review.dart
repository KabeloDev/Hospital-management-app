import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late TextEditingController hosNameController;
  late TextEditingController hosExController;
  final firestoreRev = FirebaseFirestore.instance.collection("reviews");

  @override
  void initState() {
    hosNameController = TextEditingController();
    hosExController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    hosNameController.dispose();
    hosExController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text("Review Page", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello there! we would like to hear from you how you've found the service & treatment\nyou've received at one of our hospitals and at which hospital. We find that this kind of \nfeedback helps us improve our services and provide a better experience\nfor our clientele.",
              ),
              const SizedBox(height: 10),
              const Text(
                "In the textfields below you will enter the name of the hospital you attended in the first textfield\nand how you found the service at that hospital\n",
              ),
              const SizedBox(height: 10),
              //HOSPITAL NAME TEXTFIELD---------------------------------------------------
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: hosNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Hospital Name",
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 62, 87, 228)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 87, 228)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 62, 87, 228))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //HOSPITAL Experience TEXTFIELD---------------------------------------------------
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: hosExController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Hospital Experience",
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 62, 87, 228)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 87, 228)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 62, 87, 228))),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Consumer<AppProvider>(
                builder: (context, value, child) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 29, 54, 193),
                    minimumSize: const Size(200, 45),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () async {
                    String id = firestoreRev.doc().id;
                    await firestoreRev.doc(id).set(
                      {
                        "username": value.userName,
                        "hospital name": hosNameController.text,
                        "hospital experience": hosExController.text,
                        "id": id,
                      },
                    );
                    context.read<AppProvider>().reviewInfo(
                        "I was at $hosNameController", "$hosExController");
                    Navigator.pushNamed(context, RouteManager.mainPage);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Review successfully submitted."),
                      ),
                    );
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
