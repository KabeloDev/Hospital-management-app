import 'package:flutter/material.dart';
import 'package:hospital_management_app/pages/adminpage.dart';
import 'package:hospital_management_app/pages/adminusers.dart';
import 'package:hospital_management_app/pages/appointments.dart';
import 'package:hospital_management_app/pages/appontmentlist.dart';
import 'package:hospital_management_app/pages/login.dart';
import 'package:hospital_management_app/pages/mainpage.dart';
import 'package:hospital_management_app/pages/profile.dart';
import 'package:hospital_management_app/pages/register.dart';
import 'package:hospital_management_app/pages/review.dart';
import 'package:hospital_management_app/pages/reviewlist.dart';

class RouteManager {
  static const String loginPage = "/";
  static const String registerPage = "/loginPage";
  static const String mainPage = "/mainpage";
  static const String appointments = "/appointments";
  static const String myProfile = "/myprofile";
  static const String reviewPage = "/reviewpage";
  static const String adminPage = "/adminPage";
  static const String apptListPage = "/apptListPage";
  static const String revListPage = "/revListPage";
  static const String userListPage = "/userListPage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );

      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
      case appointments:
        return MaterialPageRoute(
          builder: (context) => const Appointments(),
        );
      case myProfile:
        return MaterialPageRoute(
          builder: (context) => const MyProfile(),
        );
      case reviewPage:
        return MaterialPageRoute(
          builder: (context) => const ReviewPage(),
        );
      case adminPage:
        return MaterialPageRoute(
          builder: (context) => const AdminPage(),
        );
      case apptListPage:
        return MaterialPageRoute(
          builder: (context) => const ApptListPage(),
        );
      case revListPage:
        return MaterialPageRoute(
          builder: (context) => const RevListPage(),
        );
      case userListPage:
        return MaterialPageRoute(
          builder: (context) => const UserListtPage(),
        );
      default:
        throw const FormatException('Route not found! check routes again!');
    }
  }
}
