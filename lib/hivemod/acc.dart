import 'package:hive/hive.dart';

part 'acc.g.dart'; // Auto-generated file

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  Account({required this.email, required this.password});
}
