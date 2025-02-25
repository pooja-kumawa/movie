import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization

  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('contacts'); // Open the contacts box only once

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
