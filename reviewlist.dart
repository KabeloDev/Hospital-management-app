import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RevListPage extends StatefulWidget {
  const RevListPage({super.key});

  @override
  State<RevListPage> createState() => _RevListPageState();
}

class _RevListPageState extends State<RevListPage> {
  int usernameCounterUser = 0;
  var userCollection = FirebaseFirestore.instance.collection("reviews");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text("Review List", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
          builder: (context, snapshot) {
            List<Column> apptWidgets = [];

            if (snapshot.hasData) {
              final appts = snapshot.data?.docs.reversed.toList();
              for (var appt in appts!) {
                String username = appt['username'];
                String revId = appt['id'];
                final apptWidget = Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Click on user email to view user review",
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
                                                        .doc(revId)
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
                                              content:
                                                  const Text("Delete review"),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          username,
                                        ),
                                      ),
                                      Text(
                                        appt['hospital name'],
                                      ),
                                      Text(
                                        appt['hospital experience'],
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
