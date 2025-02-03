import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/common/profile_listing.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/ui/screens/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Profile", hasBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80, // Size of the circle avatar
              backgroundImage: NetworkImage(
                "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Anon Thammasat",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "MFU 66",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              "Software Engineering",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              text: "Edit Profile",
              key: _formKey,
              width: 400,
            ),
            SizedBox(
              height: 10,
            ),
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
        ),
      ),
    );
  }
}
