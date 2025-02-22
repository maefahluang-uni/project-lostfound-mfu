import 'package:lost_found_mfu/models/post_item.dart';

class User {
  final String uid;
  final String fullName;
  final String email;
  final String? bio;
  final PostItem? postItem;

  User(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.bio,
      required this.postItem});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        uid: data['uid'],
        fullName: data['fullName'],
        email: data['email'],
        bio: data['bio'],
        postItem: data['postItem']);
  }
}
