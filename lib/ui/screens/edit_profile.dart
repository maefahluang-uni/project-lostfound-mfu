import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/ui/screens/profile.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _editUsernameController = TextEditingController();
  final _editBioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Edit Profile", hasBackArrow: true),
      body: Column(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 80, // Size of the avatar
                  backgroundImage: NetworkImage(
                    "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
                  ),
                ),
                const SizedBox(height: 20), // Spacing between avatar and button
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
                      borderRadius: BorderRadius.circular(30), // Rounded edges
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
                  alignment:
                      Alignment.centerLeft, // Align only this text to the left
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
                CustomTextField(controller: _editUsernameController, label: ""),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment:
                      Alignment.centerLeft, // Align only this text to the left
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
                  label: "",
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Save Changes',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
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
