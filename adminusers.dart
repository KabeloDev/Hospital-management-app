import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListtPage extends StatefulWidget {
  const UserListtPage({super.key});

  @override
  State<UserListtPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListtPage> {
  int usernameCounterUser = 0;
  var userCollection = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text("User List", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                    "Click on user email to view details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
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
                                                child: const Icon(Icons.delete),
                                              ),
                                            ],
                                            title: const Text("Delete"),
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            content: Text("Delete $username"),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        username,
                                      ),
                                    ),
                                    Text(
                                      appt['first name'],
                                    ),
                                    Text(
                                      appt['last name'],
                                    ),
                                    Text(
                                      appt['id number'],
                                    ),
                                    Text(
                                      appt['date of birth'],
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
    );
  }
}
