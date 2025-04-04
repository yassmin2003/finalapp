import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hivemod/acc.dart';  // Your account model
import 'hivemod/fav.dart';  // Your favorite quote model
import 'widg/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();


  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(FavoriteQuoteAdapter());


  await Hive.openBox<Account>('account');
  await Hive.openBox<FavoriteQuote>('favorite_quotes');

  runApp(MyApp());
}
