import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:project_latihan/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _getLogout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("login");
    Loader.show(context, progressIndicator: const LinearProgressIndicator());
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()));
      Loader.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("This is Account Page"),
              TextButton(
                  onPressed: () {
                    _getLogout();
                  },
                  child: const Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
