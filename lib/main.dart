import 'package:flutter/material.dart';
import 'package:lost_found_mfu/ui/screens/about.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/login.dart';
import 'package:lost_found_mfu/ui/screens/setting.dart';
import 'package:lost_found_mfu/ui/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost & Found in MFU',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/setting',
      routes: {
        '/': (context) => const Home(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
        '/setting': (context) => Setting(),
        '/about': (context) => About()
      },
    );
  }
}
