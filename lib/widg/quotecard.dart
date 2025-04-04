import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../hivemod/fav.dart'; // Make sure the correct import for FavoriteQuote is used

class QuoteCard extends StatefulWidget {
  final String quote;
  final String author;

  const QuoteCard({Key? key, required this.quote, required this.author}) : super(key: key);

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeFavoriteStatus();
  }

  // Check if the quote is already in the favorites when the widget is initialized
  Future<void> _initializeFavoriteStatus() async {
    var favBox = await Hive.openBox<FavoriteQuote>('favorite_quotes');
    bool isFavorite = favBox.values.any((quote) => quote.content == widget.quote && quote.author == widget.author);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${widget.quote}"',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black87),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "- ${widget.author}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: () async {
                var favBox = await Hive.openBox<FavoriteQuote>('favorite_quotes');
                var favoriteQuote = FavoriteQuote(content: widget.quote, author: widget.author);

                if (_isFavorite) {
                  // Remove from favorites if it's already a favorite
                  var index = favBox.values.toList().indexWhere((quote) => quote.content == widget.quote && quote.author == widget.author);
                  favBox.deleteAt(index);
                  setState(() {
                    _isFavorite = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quote removed from favorites!')),
                  );
                } else {
                  // Add to favorites
                  favBox.add(favoriteQuote);
                  setState(() {
                    _isFavorite = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Quote added to favorites!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
