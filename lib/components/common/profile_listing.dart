import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/status_badge.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ProfileListing extends StatefulWidget {
  const ProfileListing({super.key});

  @override
  State<ProfileListing> createState() => _ProfileListingState();
}

class _ProfileListingState extends State<ProfileListing> {
  String postStatus = 'Published';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Macbook",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Your post have been approved",
                style: TextStyle(color: AppColor.theme.hintColor),
              )
            ],
          ),
          Column(
            children: [
              StatusBadge(status: postStatus),
              SizedBox(
                height: 6,
              ),
              Text(
                "Jan 14",
                style: TextStyle(fontSize: 12, color: AppColor.theme.hintColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
