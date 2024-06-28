import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/provider/provider.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //These are the firebase options from my firebase acc
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDZzatncXDOfEOKuVp27BO6ZX0sTpEqepY",
          authDomain: "hospital-managent-app.firebaseapp.com",
          projectId: "hospital-managent-app",
          storageBucket: "hospital-managent-app.appspot.com",
          messagingSenderId: "905883849241",
          appId: "1:905883849241:web:ef6dc9c82dd7f3e2531088",
          measurementId: "G-5HGNJYG0ZM"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior()
            .copyWith(dragDevices: {PointerDeviceKind.mouse}),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.loginPage,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
