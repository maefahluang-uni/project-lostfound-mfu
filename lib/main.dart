import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_found_mfu/ui/screens/notification_screen.dart';
import 'package:lost_found_mfu/ui/screens/profile.dart';
import 'package:lost_found_mfu/ui/screens/setting/about.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_screen.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/auth/login.dart';
import 'package:lost_found_mfu/ui/screens/setting/setting.dart';
import 'package:lost_found_mfu/ui/screens/auth/signup.dart';

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
        textTheme: GoogleFonts.manropeTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
        '/setting': (context) => Setting(),
        '/about': (context) => About(),
        '/chat': (context) => ChatScreen(),
        '/notification': (context) => NotificationScreen(),
        '/profile': (context) => Profile()
      },
    );
  }
}
