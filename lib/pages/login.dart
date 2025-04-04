import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../hivemod/acc.dart';
import 'navbar.dart';  // Assuming you have a Navbar page or you can replace it with the main app page like QuoteApp

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Login method
  void _login() async {
    var accountBox = await Hive.openBox<Account>('account');
    var loginBox = await Hive.openBox('login_state');

    // Check if account exists
    var account = accountBox.get('user_account');
    if (account != null &&
        account.email == _emailController.text &&
        account.password == _passwordController.text) {
      // Successful login, save login state
      loginBox.put('is_logged_in', true);

      // Navigate to main page (e.g., QuoteApp)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuoteApp()), // Replace with your main app page
      );
    } else {
      // Handle invalid login attempt
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid login credentials')));
    }
  }

  // Create account method
  void _createAccount() async {
    var accountBox = await Hive.openBox<Account>('account');
    var loginBox = await Hive.openBox('login_state');

    var account = Account(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // Save the account info
    accountBox.put('user_account', account);

    // Set login state to true
    loginBox.put('is_logged_in', true);

    // Navigate to main app (e.g., QuoteApp)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QuoteApp()), // Replace with your main app page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, // Login button
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createAccount, // Create account button
              child: Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
