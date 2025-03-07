import 'package:flutter/material.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';
import 'package:lost_found_mfu/models/post_item.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';

class DetailScreen extends StatefulWidget {
  final String postId;

  const DetailScreen({super.key, required this.postId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  PostItem? item;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPostDetails();
  }

  Future<void> fetchPostDetails() async {
    try {
      final Map<String, dynamic>? postData =
          await PostApiHelper.getSinglePost(widget.postId);

      if (postData == null ||
          !postData.containsKey('post') ||
          postData['post'] == null) {
        setState(() {
          errorMessage = "No data found";
          isLoading = false;
        });
        return;
      }
      setState(() {
        item = PostItem.fromJson(postData['post']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Post Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: RefreshIndicator(
          onRefresh: fetchPostDetails,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
                  ? Center(
                      child: Text("Error: $errorMessage"),
                    )
                  : item == null
                      ? const Center(
                          child: Text("No data found"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        item!.post.postOwner.photoURL.isNotEmpty
                                            ? NetworkImage(item!.post.postOwner
                                                .photoURL) // Online image
                                            : const AssetImage(
                                                    "assets/images/user.jpeg")
                                                as ImageProvider,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${item!.post.postOwner.displayName}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text("Item : ${item!.post.item}",
                                      style: const TextStyle(fontSize: 16)),
                                  SizedBox(width: 100),
                                  Text("Status : ${item!.post.itemStatus}",
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Color : ${item!.post.color}",
                                  style: const TextStyle(fontSize: 16)),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text("Date : ${item!.post.date}",
                                      style: const TextStyle(fontSize: 16)),
                                  SizedBox(width: 60),
                                  Text("Time : ${item!.post.time}",
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Location : ${item!.post.location}",
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Text("Description : ${item!.post.desc}",
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),
                              Text('Contact Details',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("Email : ${item!.post.postOwner.email}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              Text("Phone : ${item!.post.phone}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              if (item!.post.photos.isNotEmpty)
                                SizedBox(
                                  height: 340,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: item!.post.photos.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              item!.post.photos[index],
                                              width: 340,
                                              fit: BoxFit.fill,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/macbook.jpg',
                                                  width: 450,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
        ));
  }
}
