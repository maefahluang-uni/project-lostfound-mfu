import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_post_component.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';

class AllPost extends StatefulWidget {
  const AllPost({super.key});

  @override
  State<AllPost> createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  String? _userId;
  late Future<List<Map<String, dynamic>>> _futurePosts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
    loadUserData();
  }

  void loadUserData() async {
    String? userId = await PostApiHelper.getUserId();
    if (userId != null) {
      setState(() {
        _userId = userId;
        _futurePosts = fetchPosts();
      });
    } else {
      print("UserId is missing. Fetching posts will fail.");
      setState(() {
        _futurePosts = Future.value([]);
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      List<Map<String, dynamic>> data = await PostApiHelper.getPosts();
      // print("Fetched Posts: $data");
      return data;
    } catch (e) {
      print("Error fetching posts: $e"); // 🔹 Log errors in debug console
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No posts available."));
              }

              List<Map<String, dynamic>> postsData = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: postsData.map((post) {
                    return CustomPostComponent(postData: post);
                  }).toList(),
                ),
              );
            }));
  }
}
