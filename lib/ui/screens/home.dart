import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/sos_button.dart';
import 'package:lost_found_mfu/components/utils/bottom_navigation.dart';
import 'package:lost_found_mfu/components/utils/custom_tabbar.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_screen.dart';
import 'package:lost_found_mfu/ui/screens/notification_screen.dart';
import 'package:lost_found_mfu/ui/screens/post.dart';
import 'package:lost_found_mfu/ui/screens/post/upload_post.dart';
import 'package:lost_found_mfu/ui/screens/profile.dart';
import 'package:lost_found_mfu/ui/screens/search.dart';
import 'package:lost_found_mfu/ui/screens/setting/setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    Center(child: Text("Home Screen")),
    Search(),
    UploadPostScreen(),
    ChatScreen(),
    Setting()
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      _pages[0] = _homeComponents();
    }
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _homeComponents() {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lost & Found in MFU',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.notifications_active,
            color: Colors.red,
          ),
          onPressed: () {
            // Handle notification action
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen()));
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Profile()), // Assuming you want to navigate to Setting
              );
            },
            child: CircleAvatar(
              radius: 18, // Size of the circle avatar
              backgroundImage: NetworkImage(
                "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
              ),
            ),
          ),
          const SizedBox(width: 10), // Add spacing from the edge
        ],
      ),
      body: Stack(children: [
        Column(
          children: [Expanded(child: CustomTabbar())],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: SosButton(), // This will float above the posts
        ),
      ]),
    );
    return scaffold;
  }
}
