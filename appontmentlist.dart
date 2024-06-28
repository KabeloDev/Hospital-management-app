import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApptListPage extends StatefulWidget {
  const ApptListPage({super.key});

  @override
  State<ApptListPage> createState() => _ApptListPageState();
}

class _ApptListPageState extends State<ApptListPage> {
  var userCollection = FirebaseFirestore.instance.collection("appointments");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text("Appointments List",
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('appointments').snapshots(),
          builder: (context, snapshot) {
            List<Column> apptWidgets = [];

            if (snapshot.hasData) {
              final appts = snapshot.data?.docs.reversed.toList();
              for (var appt in appts!) {
                String username = appt['username'];
                String apptId = appt['id'];
                final apptWidget = Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Click on user email to view appointment details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                                  title: const Text(
                                      "Click on user email to delete user"),
                                  contentPadding: const EdgeInsets.all(15),
                                  content: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    userCollection
                                                        .doc(apptId)
                                                        .delete();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                              ],
                                              title: const Text("Delete"),
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              content: const Text(
                                                  "Delete appointment"),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          username,
                                        ),
                                      ),
                                      Text(
                                        appt['appointment date'],
                                      ),
                                      Text(
                                        appt['appointment time'],
                                      ),
                                    ],
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(
                                Icons.person,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(' $username',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
                apptWidgets.add(apptWidget);
              }
            }
            return Expanded(
              child: ListView(
                children: apptWidgets,
              ),
            );
          },
        ),
      ),
    );
  }
}
