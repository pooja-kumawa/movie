import 'package:hive/hive.dart';

part 'contact.g.dart'; // Required for generating Hive TypeAdapter

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String number;

  Contact({required this.name, required this.number});
}
