import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/copy_link.dart';
import 'package:lost_found_mfu/helpers/chat_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/detail.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPostComponent extends StatefulWidget {
  final Map<String, dynamic> postData;

  const CustomPostComponent({super.key, required this.postData});

  @override
  _CustomPostComponentState createState() => _CustomPostComponentState();
}

class _CustomPostComponentState extends State<CustomPostComponent> {
  late Map<String, dynamic> postData;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    postData = widget.postData;
    initUserData();
  }

  Future<void> initUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });
  }

  void handleMenuSelection(String value) {
    if (value == 'resolve') {
      setState(() {
        postData['itemStatus'] = 'Resolved'; // Update the UI immediately
      });
      print("Resolve clicked");
    } else if (value == 'delete') {
      setState(() {
        postData['itemStatus'] =
            'Deleted'; // Handle delete, remove post if necessary
      });
      print("Delete clicked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          UserInfoRow(
            postData: postData,
            handleMenuSelection: handleMenuSelection,
          ),
          const SizedBox(height: 10),
          PostImage(postData: postData),
          const SizedBox(height: 10),
          PostActions(
            id: postData['id'],
            postData: postData,
            currentUserId: currentUserId ?? '',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                postData['desc'] ?? "No description available.",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 50, 50, 50)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                postData['date'] ?? "Unknown time",
                style: TextStyle(fontSize: 14, color: AppColor.theme.hintColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final Map<String, dynamic> postData;
  final void Function(String) handleMenuSelection;

  const UserInfoRow(
      {super.key, required this.postData, required this.handleMenuSelection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: postData['postOwner']['profileImage'] != null &&
                      postData['postOwner']['profileImage'].isNotEmpty
                  ? NetworkImage(
                      postData['postOwner']['profileImage']) // Online image
                  : AssetImage("assets/images/user.jpeg") as ImageProvider,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postData['postOwner']['displayName'] ?? "Unknown User",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  postData['location'] ?? "Unknown Location",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Badge(
              label: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  postData['item'],
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 82, 157, 255),
            ),
            IconButton(
              onPressed: () {},
              icon: SizedBox(
                width: 50,
                height: 25,
                child: Badge(
                  label: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      postData['itemStatus'],
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  backgroundColor: postData['itemStatus'] == 'Lost'
                      ? Colors.redAccent
                      : Colors.green,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// Post Image Section
class PostImage extends StatelessWidget {
  final Map<String, dynamic> postData;

  const PostImage({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    bool hasPhotos =
        postData['photos'] != null && postData['photos'].isNotEmpty;
    String imageUrl =
        hasPhotos ? postData['photos'][0] : "assets/images/macbook.jpg";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 300,
      width: double.infinity, // Ensure full width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Apply border radius to image
        child: Image.network(
          imageUrl,
          width: double.infinity, // Ensure full width
          height: 400, // Maintain container height
          fit: BoxFit.cover, // Stretch image to cover the container
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/macbook.jpg",
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

// Actions (Message & Copy Link)
class PostActions extends StatelessWidget {
  final String id;
  final Map<String, dynamic> postData;
  final String currentUserId;

  PostActions(
      {super.key,
      required this.id,
      required this.postData,
      required this.currentUserId});

  void _showMessagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Send Message"),
          content: Text(
              "Do you want to start conversation with ${postData['postOwner']['displayName'] ?? "this user"}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await ChatApiHelper.sendChatMessage(
                    message: "Hello",
                    messageType: "TEXT",
                    receiverId: postData['postOwner']['id'],
                    senderId: currentUserId);

                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Message sent successfully!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              _showMessagePopup(context); // Show popup on tap
            },
            child: Row(
              children: [
                const Icon(
                  Icons.message,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text("Message", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          CopyLink(postId: id),
          const SizedBox(width: 8),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(postId: id),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "View Detail",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
