import 'package:flutter/material.dart';
import 'package:hospital_management_app/pages/login.dart';

class AppProvider with ChangeNotifier {
  /* Rebuilding text field widgets */
  Widget currentScreen_ = const LoginPage();

  set currentScreen(Widget newScreen) {
    currentScreen_ = newScreen;
    notifyListeners();
  }

  Widget get currentScreen => currentScreen_;

  /// ****************************************

  /* Storing and passing Login info */
  String? name = "";

  void changeUserName(String? newUserName) {
    name = newUserName;
    notifyListeners();
  }

  String? get userName => name;

  /// ****************************************

  /* Storing and passing appointment info */
  String date = "";
  String time = "";

  void appointMentInfo(String newDate, String newTime) {
    date = newDate;
    time = newTime;
    notifyListeners();
  }

  String get apptDate => date;
  String get apptTime => time;

  /// ****************************************

  /* Storing and passing review info */
  String hosReview = "";
  String hosName = "";

  void reviewInfo(String newHosName, String newHosReview) {
    hosName = newHosName;
    hosReview = newHosReview;
    notifyListeners();
  }

  String get revHosName => hosName;
  String get revHosReview => hosReview;

  /// ****************************************
}
