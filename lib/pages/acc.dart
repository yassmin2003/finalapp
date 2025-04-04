import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AccountPage extends StatefulWidget {
  final VoidCallback onLogout;
  final ValueChanged<bool> onThemeChanged;
  final bool isDarkMode;

  AccountPage({
    required this.onLogout,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mode", style: TextStyle(fontSize: 18)),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    widget.onThemeChanged(_isDarkMode);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onLogout,
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  // Handle logout logic
  void _onLogout() async {
    // Clear login state from Hive
    var loginBox = await Hive.openBox('login_state');
    loginBox.put('is_logged_in', false);

    // Navigate to login page
    widget.onLogout();
  }
}
