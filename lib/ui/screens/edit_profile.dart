import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/profile.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _editUsernameController = TextEditingController();
  final TextEditingController _editBioController = TextEditingController();
  String profileImageUrl = "assets/images/user.jpeg";
  bool isLoading = true;

  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userData = await UserApiHelper.getUserProfile();
    setState(() {
      _editUsernameController.text = userData['fullName'] ?? '';
      _editBioController.text = userData['bio'] ?? '';
      profileImageUrl = ((userData['profileImage'] != null &&
              userData['profileImage']!.isNotEmpty)
          ? userData['profileImage']
          : "assets/images/user.jpeg")!;
      isLoading = false;
    });
  }

  Future<void> _updateUserProfile() async {
    final name = _editUsernameController.text.trim();
    final bio = _editBioController.text.trim();

    print("$name : $bio");

    final response =
        await UserApiHelper.updateUserProfile(name, bio, profileImageUrl);

    if (response.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')));
      await _loadUserProfile();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Falied to update profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Edit Profile", hasBackArrow: true),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 80, // Size of the avatar
                          backgroundImage: AssetImage(profileImageUrl)),
                      const SizedBox(
                          height: 20), // Spacing between avatar and button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add your edit profile logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColor.theme.primaryColor, // Button color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Rounded edges
                          ),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          "Edit Photo",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align only this text to the left
                        child: const Text(
                          "Edit Username",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(controller: _editUsernameController),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment
                            .centerLeft, // Align only this text to the left
                        child: const Text(
                          "Edit Bio",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextField(
                        controller: _editBioController,
                        height: 200,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: 'Save Changes',
                        onPressed: _updateUserProfile,
                        width: 400,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
