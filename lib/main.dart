import 'package:expense_tracker/service/pref.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref.initPref();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
