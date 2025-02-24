import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';

class LostPost extends StatefulWidget {
  const LostPost({super.key});

  @override
  State<LostPost> createState() => _LostPostState();
}

class _LostPostState extends State<LostPost> {
  late Future<List<Map<String, dynamic>>> lostPosts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    lostPosts = fetchLostPosts();
  }

  Future<List<Map<String, dynamic>>> fetchLostPosts() async {
    List<Map<String, dynamic>> data = await PostApiHelper.getPosts("Lost");

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: lostPosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No posts available."));
            }

            List<Map<String, dynamic>> lostPostsData = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lostPostsData.map((post) {
                    return CustomPostComponent(postData: post);
                  }).toList()),
            );
          }),
    );
  }
}
