import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var userCollection = FirebaseFirestore.instance.collection("users");
  int usernameCounterUser = 0;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newDateofbirth = TextEditingController();
  TextEditingController newIdNumber = TextEditingController();
  TextEditingController newContactNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title:
            const Text("Profile Page", style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: value.userName)
              .snapshots(),
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
                    const SizedBox(height: 20),
                    const Text(
                      "Click on item you want to update",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('ok'),
                              ),
                            ],
                            title: const Text("Email Address"),
                            contentPadding: const EdgeInsets.all(15),
                            content: const Text("Cannot change email address"),
                          ),
                        );
                      },
                      child: Text(
                        'Email Address: $username',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              Consumer<AppProvider>(
                                builder: (context, value, child) => TextButton(
                                  onPressed: () async {
                                    //firstNameController.text = appt['first name'];
                                    await userCollection.doc(apptId).update({
                                      'password': newPasswordController.text
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ),
                            ],
                            title: const Text("Change password"),
                            contentPadding: const EdgeInsets.all(15),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Consumer<AppProvider>(
                                    builder: (context, value, child) =>
                                        TextFormField(
                                      controller: newPasswordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your Password";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Password",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Password: ${appt['password']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              Consumer<AppProvider>(
                                builder: (context, value, child) => TextButton(
                                  onPressed: () async {
                                    //firstNameController.text = appt['first name'];
                                    await userCollection.doc(apptId).update({
                                      'first name': firstNameController.text
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ),
                            ],
                            title: const Text("Change first name"),
                            contentPadding: const EdgeInsets.all(15),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Consumer<AppProvider>(
                                    builder: (context, value, child) =>
                                        TextFormField(
                                      controller: firstNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your first name";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "First Name",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'First Name: ${appt['first name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              Consumer<AppProvider>(
                                builder: (context, value, child) => TextButton(
                                  onPressed: () async {
                                    //firstNameController.text = appt['first name'];
                                    await userCollection.doc(apptId).update(
                                        {'last name': lastNameController.text});
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ),
                            ],
                            title: const Text("Change last name"),
                            contentPadding: const EdgeInsets.all(15),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Consumer<AppProvider>(
                                    builder: (context, value, child) =>
                                        TextFormField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your last name";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Last Name",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Last Name: ${appt['last name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              Consumer<AppProvider>(
                                builder: (context, value, child) => TextButton(
                                  onPressed: () async {
                                    //firstNameController.text = appt['first name'];
                                    await userCollection.doc(apptId).update(
                                        {'date of birth': newDateofbirth.text});
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ),
                            ],
                            title: const Text("Change date of birth"),
                            contentPadding: const EdgeInsets.all(15),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Consumer<AppProvider>(
                                    builder: (context, value, child) =>
                                        TextFormField(
                                      controller: newDateofbirth,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your last name";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Date Of Birth",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Date Of Birth: ${appt['date of birth']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              Consumer<AppProvider>(
                                builder: (context, value, child) => TextButton(
                                  onPressed: () async {
                                    //firstNameController.text = appt['first name'];
                                    await userCollection.doc(apptId).update({
                                      'contact number': newContactNumber.text
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ok"),
                                ),
                              ),
                            ],
                            title: const Text("Change contact number"),
                            contentPadding: const EdgeInsets.all(15),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Consumer<AppProvider>(
                                    builder: (context, value, child) =>
                                        TextFormField(
                                      controller: newContactNumber,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your contact number";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Contact Number",
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Contact Number: ${appt['contact number']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AppProvider>(
                      builder: (context, value, child) => InkWell(
                        onTap: () async {
                          var num = await userCollection
                              .where("username", isEqualTo: value.userName)
                              .get();
                          setState(() {
                            usernameCounterUser = num.size;
                          });

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    //userCollection.doc(apptId).delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('ok'),
                                ),
                              ],
                              title: const Text("ID number"),
                              contentPadding: const EdgeInsets.all(15),
                              content: const Text("Cannot change ID number"),
                            ),
                          );
                        },
                        child: Text(
                          'ID Number: ${appt['id number']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
