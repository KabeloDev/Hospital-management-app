import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  String? timeChosen;
  List<String> times = [
    "08:00 - 09:00",
    "09:00 - 10:00",
    "11:00 - 12:00",
    "13:00 - 14:00",
    "15:00 - 16:00"
  ];

  TextEditingController appointmentText = TextEditingController();

  final firestoreAppt = FirebaseFirestore.instance.collection("appointments");

  int usernameCounterAppt = 0;

  var apptCollection = FirebaseFirestore.instance.collection("appointments");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromRGBO(135, 171, 255, 1),
        centerTitle: true,
        title: const Text(
          "Appointments",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selected day: ${today.toString().split(" ")[0]}",
                    ),
                    TableCalendar(
                      locale: "en_US",
                      rowHeight: 40,
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      focusedDay: today,
                      firstDay: DateTime.utc(2024, 05, 01),
                      lastDay: DateTime.utc(2024, 07, 01),
                      onDaySelected: _onDaySelected,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: const Color.fromARGB(255, 29, 54, 193),
                        ),
                        child: DropdownButton(
                          hint: const Text(
                            "Select time slot",
                          ),
                          value: timeChosen,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (newTime) {
                            setState(() {
                              timeChosen = newTime.toString();
                            });
                          },
                          items: times.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: appointmentText,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Appointment reason",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 62, 87, 228)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 62, 87, 228)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 62, 87, 228)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AppProvider>(
                      builder: (context, value, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 29, 54, 193)),
                        onPressed: () async {
                          context.read<AppProvider>().appointMentInfo(
                                "${today.year} - ${today.month} - ${today.day}",
                                timeChosen.toString(),
                              );
                          String id = firestoreAppt.doc().id;
                          await firestoreAppt.doc(id).set(
                            {
                              "username": value.userName,
                              "appointment date": value.apptDate,
                              "appointment time": value.apptTime,
                              "reason": appointmentText.text,
                              "id": id
                            },
                          );
                          var num = await apptCollection
                              .where("username", isEqualTo: value.userName)
                              .get();
                          setState(() {
                            usernameCounterAppt = num.size;
                          });
                          if (usernameCounterAppt == 1) {
                            context.read<AppProvider>().appointMentInfo(
                                value.apptDate, value.apptTime);
                          }
                          Navigator.pushNamed(context, RouteManager.mainPage);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Appointment successfully submitted."),
                            ),
                          );
                        },
                        child: const Text(
                          "Submit Appointment",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
