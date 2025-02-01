import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/all_post.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';
import 'package:lost_found_mfu/components/common/found_post.dart';
import 'package:lost_found_mfu/components/common/lost_post.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white24,
            child: const TabBar(
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
              tabs: <Widget>[
                Tab(text: 'All'),
                Tab(text: 'Lost'),
                Tab(text: 'Found'),
              ],
            ),
          ),
          Expanded(
            child: const TabBarView(
              children: <Widget>[
                Center(child: AllPost()),
                Center(child: LostPost()),
                Center(child: FoundPost()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
