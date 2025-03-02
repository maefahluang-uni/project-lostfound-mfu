import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/status_badge.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ProfileListing extends StatelessWidget {
  final String postId;
  final String item;
  final String status;
  final String date;
  final String description;
  final Function(String newStatus) onStatusUpdate;
  final VoidCallback onDelete;

  const ProfileListing({
    super.key,
    required this.postId,
    required this.item,
    required this.status,
    required this.date,
    required this.description,
    required this.onStatusUpdate,
    required this.onDelete,
  });

  void deletePost(BuildContext context, String postId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      try {
        await PostApiHelper.deletePost(postId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post deleted successfully")),
        );
        onDelete(); // Trigger UI update
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error deleting post: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(color: AppColor.theme.hintColor),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  StatusBadge(status: status),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 12, color: AppColor.theme.hintColor),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'resolved') {
                    onStatusUpdate('Resolved');
                  }
                  if (value == 'delete') {
                    deletePost(context, postId);
                  }
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'resolved',
                    child: Row(
                      children: [
                        Text('Resolve', style: TextStyle(color: Colors.green)),
                        SizedBox(width: 6),
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
      ),
    );
  }
}
