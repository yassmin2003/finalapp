import 'package:flutter/material.dart';
import 'FavoritesPage.dart';
import 'acc.dart';
import 'home.dart';
import 'login.dart';

class QuoteApp extends StatefulWidget {
  @override
  _QuoteAppState createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  void _onLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _onThemeChanged(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text("Quote App")),
        body: _currentIndex == 0
            ? HomePage()
            : _currentIndex == 1
            ? FavoritesPage() // Now it will show the FavoritesPage
            : AccountPage(
          onLogout: _onLogout,
          onThemeChanged: _onThemeChanged,
          isDarkMode: _isDarkMode,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
          ],
        ),
      ),
    );
  }
}
