import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/quoteservice.dart';
import '../widg/quotecard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> quotes = [];
  bool isLoading = true;
  final QuoteService quoteService = QuoteService(Dio());

  @override
  void initState() {
    super.initState();
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    List<dynamic> fetchedQuotes = await quoteService.getQuotes();
    setState(() {
      quotes = fetchedQuotes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quotes")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          var quote = quotes[index];
          return QuoteCard(
            quote: quote['content'],
            author: quote['author'] ?? 'Unknown',
          );
        },
      ),
    );
  }
}
