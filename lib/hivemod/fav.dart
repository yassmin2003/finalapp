import 'package:hive/hive.dart';

part 'fav.g.dart'; // Auto-generated file

@HiveType(typeId: 1)
class FavoriteQuote extends HiveObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final String author;

  FavoriteQuote({required this.content, required this.author});
}
