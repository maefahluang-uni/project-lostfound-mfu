import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/common/notification_card.dart';
import 'package:lost_found_mfu/components/utils/bottom_navigation.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_screen.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/post.dart';
import 'package:lost_found_mfu/ui/screens/search.dart';
import 'package:lost_found_mfu/ui/screens/setting/setting.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    NotificationScreen(),
    Home(),
    Search(),
    Post(),
    ChatScreen(),
    Setting()
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      _pages[0] = NotificationScreen();
    }
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Notifications"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
