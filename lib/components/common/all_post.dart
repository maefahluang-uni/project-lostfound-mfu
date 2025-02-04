import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';

class AllPost extends StatefulWidget {
  const AllPost({super.key});

  @override
  State<AllPost> createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomPostComponent(),
            CustomPostComponent(),
            CustomPostComponent(),
          ],
        ),
      ),
    );
  }
}
