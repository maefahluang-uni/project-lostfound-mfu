import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/copy_link.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class CustomPostComponent extends StatelessWidget {
  final Map<String, dynamic> postData;

  const CustomPostComponent({super.key, required this.postData});

  void handleMenuSelection(String value) {
    if (value == 'resolve') {
      print("Resolve clicked");
    } else if (value == 'delete') {
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
              postData: postData, handleMenuSelection: handleMenuSelection),
          const SizedBox(height: 10),
          PostImage(postData: postData),
          const SizedBox(height: 10),
          PostActions(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                postData['desc'] ?? "No description available.",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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

// User Information Row with Avatar, Name, and Location
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
              backgroundImage: postData['userImage'] != null &&
                      postData['userImage'].isNotEmpty
                  ? NetworkImage(postData['userImage']) // Online image
                  : const AssetImage("assets/images/user.jpeg")
                      as ImageProvider,
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
            IconButton(
                onPressed: () {},
                icon: Badge(
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
                )),
            PopupMenuButton<String>(
              onSelected: handleMenuSelection,
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'resolve',
                  child: Row(
                    children: [
                      Text('Resolve', style: TextStyle(color: Colors.green)),
                      SizedBox(width: 8),
                      Icon(Icons.done_all, color: Colors.green),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Text("Delete", style: TextStyle(color: Colors.red)),
                      SizedBox(width: 8),
                      Icon(Icons.delete, color: Colors.red),
                    ],
                  ),
                ),
              ],
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Image.network(
        imageUrl,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/images/macbook.jpg");
        },
      ),
    );
  }
}

// Actions (Message & Copy Link)
class PostActions extends StatelessWidget {
  const PostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.message, color: Colors.red),
        const SizedBox(width: 8),
        const Text("Message", style: TextStyle(color: Colors.red)),
        const SizedBox(width: 20),
        CopyLink(),
      ],
    );
  }
}
