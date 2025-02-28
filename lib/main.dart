import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_found_mfu/ui/screens/notification_screen.dart';
import 'package:lost_found_mfu/ui/screens/profile.dart';
import 'package:lost_found_mfu/ui/screens/search.dart';
import 'package:lost_found_mfu/ui/screens/setting/about.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_screen.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/auth/login.dart';
import 'package:lost_found_mfu/ui/screens/setting/setting.dart';
import 'package:lost_found_mfu/ui/screens/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String initialRoute = await getInitialRoute();
  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> getInitialRoute() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  if (token != null && token.isNotEmpty) {
    return '/';
  } else {
    return '/login';
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

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
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const Home(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
        '/setting': (context) => Setting(),
        '/about': (context) => About(),
        '/chat': (context) => ChatScreen(),
        '/notification': (context) => NotificationScreen(),
        '/profile': (context) => Profile(),
        '/search': (context) => Search(),
      },
    );
  }
}
