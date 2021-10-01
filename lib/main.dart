import 'package:flutter/material.dart';
import 'package:project_latihan/pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Latihan Flutter',
      theme: ThemeData(brightness: Brightness.dark),
      home: const LoginPage(),
    );
  }
}
