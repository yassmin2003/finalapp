import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../hivemod/fav.dart';
import '../widg/quotecard.dart';  // Import the QuoteCard widget

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Box<FavoriteQuote> favBox;

  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  // Initialize Hive Box
  Future<void> _initializeHiveBox() async {
    favBox = await Hive.openBox<FavoriteQuote>('favorite_quotes');
    setState(() {});  // Trigger rebuild once the box is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favBox.isOpen // Check if the box is open
          ? ValueListenableBuilder(
        valueListenable: favBox.listenable(),
        builder: (context, Box<FavoriteQuote> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No favorite quotes yet!"));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final quote = box.getAt(index);
                return QuoteCard(
                  quote: quote!.content,
                  author: quote.author,
                );
              },
            );
          }
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
