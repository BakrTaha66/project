import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:full_project/database_local.dart';
import 'package:full_project/helper/authenticate.dart';
import 'package:full_project/screens/home_home.dart';
import 'package:full_project/screens/signin_screen.dart';
import 'package:full_project/services/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.green, scaffoldBackgroundColor: Colors.white),
      home: HomeHome(),
    );
  }
}
