import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';

class FoundPost extends StatefulWidget {
  const FoundPost({super.key});

  @override
  State<FoundPost> createState() => _FoundPostState();
}

class _FoundPostState extends State<FoundPost> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomPostComponent(),
          CustomPostComponent(),
          CustomPostComponent()
        ],
      ),
    );
  }
}
