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
      theme: ThemeData(
          primaryColor: const Color(0xff030000),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff750404)),
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontFamily: 'Staatliches',
                fontSize: 32,
                color: Color(0xffffffff)),
            button: TextStyle(
                fontSize: 18, fontFamily: 'Staatliches', color: Colors.yellow),
            headline3: TextStyle(
              fontSize: 20,
              fontFamily: 'Anton',
            ),
            headline2: TextStyle(
                fontSize: 20,
                fontFamily: 'Staatliches',
                color: Color(0xfffaf2f2)),
            headline4: TextStyle(fontSize: 22, fontFamily: 'Oxygen'),
            subtitle1: TextStyle(fontSize: 14, fontFamily: 'Oxygen'),
            subtitle2: TextStyle(fontSize: 18, fontFamily: 'Staatliches'),
            caption: TextStyle(
                fontSize: 14, fontFamily: 'Oxygen', color: Color(0XFFc9c5c5)),
          ),
          colorScheme: const ColorScheme.dark(
              primary: Color(0xff8c0000),
              onPrimary: Color(0xfffaf2f2),
              primaryVariant: Color(0xff0d0e1a),
              secondary: Color(0xffffffff),
              onSecondary: Color(0xffffffff),
              secondaryVariant: Color(0xff750404),
              surface: Color(0xFF451d1d),
              onSurface: Color(0xffdedede),
              background: Color(0xffe8c5c5),
              onBackground: Color(0xffffffff),
              error: Color(0xffffffff),
              onError: Color(0xffffffff),
              brightness: Brightness.dark)),
      home: const LoginPage(),
    );
  }
}
