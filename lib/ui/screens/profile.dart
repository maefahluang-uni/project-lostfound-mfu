import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/common/profile_listing.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Map<String, dynamic>> userProfile;
  String itemStatus = 'Pending';

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Method to load user profile
  void loadUserProfile() {
    setState(() {
      userProfile = UserApiHelper.getUserProfile();
    });
  }

  // Method to update status when resolved
  void updateStatus(String newStatus) {
    setState(() {
      itemStatus = newStatus;
    });
    loadUserProfile();
  }

  // Method to delete a post
  void deletePostFromList(String postId) {
    setState(() {
      userProfile = userProfile.then((profile) {
        profile['posts'] = (profile['posts'] as List)
            .where((post) => post['id'] != postId)
            .toList();
        return profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Profile", hasBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: FutureBuilder<Map<String, dynamic>>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error loading profile"));
            }

            final userData = snapshot.data;
            if (userData == null || userData.isEmpty) {
              return const Center(child: Text("No profile data available"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: userData['profileImage'] != null
                        ? NetworkImage(userData['profileImage'])
                        : const AssetImage("assets/images/user.jpeg")
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  userData['fullName'] ?? 'Unknown User',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  userData['bio'] ?? 'No bio available',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()),
                    );
                  },
                  text: "Edit Profile",
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: userData['posts'] != null &&
                            userData['posts'] is List &&
                            (userData['posts'] as List).isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (userData['posts'] as List<dynamic>)
                                .map((post) => ProfileListing(
                                      postId: post['id'] ?? "Invalid Id",
                                      item: post['item'] ?? "Unknown Item",
                                      status: post['itemStatus'] ??
                                          "Unknown Status",
                                      date: post['date'] ?? "No Date",
                                      description:
                                          post['desc'] ?? "No Description",
                                      onStatusUpdate: updateStatus,
                                      onDelete: () =>
                                          deletePostFromList(post['id']),
                                    ))
                                .toList(),
                          )
                        : const Center(child: Text("No posts available")),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
