import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/sos_button.dart';
import 'package:lost_found_mfu/components/utils/bottom_navigation.dart';
import 'package:lost_found_mfu/components/utils/custom_tabbar.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_screen.dart';
import 'package:lost_found_mfu/ui/screens/notification_screen.dart';
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
  late Future<Map<String, dynamic>> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = UserApiHelper.getUserProfile();
  }

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
      bottomNavigationBar: _selectedIndex == 2
          ? null
          : BottomNavigation(
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
            child: FutureBuilder<Map<String, dynamic>>(
              future: userProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleAvatar(
                      radius: 18, // Size of the circle avatar
                      backgroundImage: AssetImage("assets/images/user.jpeg"));
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading profile"));
                }
                final userData = snapshot.data;
                if (userData == null || userData.isEmpty) {
                  return const Center(child: Text("No profile data available"));
                }
                return CircleAvatar(
                    radius: 18, // Size of the circle avatar
                    backgroundImage: NetworkImage(
                        userData['profileImage'] ?? "assets/images/user.jpeg"));
              },
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
