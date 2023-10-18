import 'package:child_finder/screens/homepage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: lighttheme.appBarTheme.backgroundColor));
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      home: const HomePage(),
    );
  }
}
