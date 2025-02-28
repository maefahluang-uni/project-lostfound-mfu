import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';

class FoundPost extends StatefulWidget {
  const FoundPost({super.key});

  @override
  State<FoundPost> createState() => _FoundPostState();
}

class _FoundPostState extends State<FoundPost> {
  late Future<List<Map<String, dynamic>>> foundPosts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    foundPosts = fetchFoundPosts();
  }

  Future<List<Map<String, dynamic>>> fetchFoundPosts() async {
    List<Map<String, dynamic>> data =
        await PostApiHelper.getPosts(itemStatus: 'Found');

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: foundPosts,
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

            List<Map<String, dynamic>> foundPostsData = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: foundPostsData.map((post) {
                  return CustomPostComponent(postData: post);
                }).toList(),
              ),
            );
          }),
    );
  }
}
