
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../pages/login.dart';
import '../pages/navbar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          if (snapshot.data == true) {
            // If logged in, show main app
            return MaterialApp(home: QuoteApp());
          } else {
            // If not logged in, show login page
            return MaterialApp(home: LoginPage());
          }
        }
      },
    );
  }

  // Check the login status from Hive
  Future<bool> _checkLoginStatus() async {
    var loginBox = await Hive.openBox('login_state');
    return loginBox.get('is_logged_in', defaultValue: false);  // Return true if logged in, false otherwise
  }
}