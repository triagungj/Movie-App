import 'package:flutter/material.dart';
import 'package:project_latihan/constrants.dart';
import 'package:project_latihan/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Latihan Flutter',
      theme: ThemeData(
          primaryColor: cPrimaryColor,
          scaffoldBackgroundColor: cPrimaryLightColor),
      home: const LoginPage(),
    );
  }
}
