import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';

class LostPost extends StatefulWidget {
  const LostPost({super.key});

  @override
  State<LostPost> createState() => _LostPostState();
}

class _LostPostState extends State<LostPost> {
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
