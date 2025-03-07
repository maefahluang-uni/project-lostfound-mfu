import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/user_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
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
  File? _imageFile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userData = await UserApiHelper.getUserProfile();
    setState(() {
      _editUsernameController.text = userData['fullName'] ?? '';
      _editBioController.text = userData['bio'] ?? '';
      profileImageUrl = userData['profileImage'] ?? "assets/images/user.jpeg";
      isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateUserProfile() async {
    final name = _editUsernameController.text.trim();
    final bio = _editBioController.text.trim();

    // Convert _imageFile to Base64 or Upload it to the server
    String? updatedProfileImage =
        _imageFile != null ? _imageFile!.path : profileImageUrl;
    print('$name, $bio, $updatedProfileImage');
    final response =
        await UserApiHelper.updateUserProfile(name, bio, updatedProfileImage);

    if (response.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')));
      await _loadUserProfile();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Edit Profile", hasBackArrow: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : NetworkImage(profileImageUrl) as ImageProvider,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.theme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
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
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Username",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(controller: _editUsernameController),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Bio",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomTextField(controller: _editBioController),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Save Changes',
                        onPressed: _updateUserProfile,
                        width: 400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
