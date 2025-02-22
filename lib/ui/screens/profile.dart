import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/common/profile_listing.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/ui/screens/edit_profile.dart';
// import 'package:lost_found_mfu/api/userapi_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  late Future<Map<String, String>> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = _fetchUserProfile();
    // UserApiHelper.getUserProfile();
  }

  // Mock API function to simulate a delay and return user data
  // Have to delete after using real API
  Future<Map<String, String>> _fetchUserProfile() async {
    await Future.delayed(Duration(seconds: 2));

    return {
      'name': 'Unknown User',
      'bio': 'No bio available',
      'profile': 'assets/images/user.jpeg',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Profile", hasBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: FutureBuilder<Map<String, String>>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error loading profile"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No profile data available"));
            }

            Map<String, String> userData = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      userData['profile'] ?? "assets/images/user.jpeg"),
                ),
                SizedBox(height: 20),
                Text(
                  userData['name'] ?? 'Unknown User',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  userData['bio'] ?? 'No bio available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  },
                  text: "Edit Profile",
                  key: _formKey,
                  width: 400,
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileListing(),
                      ProfileListing(),
                      ProfileListing(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
