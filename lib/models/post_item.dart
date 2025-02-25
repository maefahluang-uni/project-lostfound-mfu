class PostItem {
  final Post post;

  PostItem({required this.post});

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      post: Post.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'PostItem { post: ${post.toString()} }';
  }
}

class Post {
  final String id;
  final String item;
  final String itemStatus;
  final String color;
  final String phone;
  final String date;
  final String time;
  final String location;
  final String desc;
  final List<String> photos;
  final String ownerId;
  final PostOwner postOwner;

  Post({
    required this.id,
    required this.item,
    required this.itemStatus,
    required this.color,
    required this.phone,
    required this.date,
    required this.time,
    required this.location,
    required this.desc,
    required this.photos,
    required this.ownerId,
    required this.postOwner,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"] ?? "",
      item: json["item"] ?? "",
      itemStatus: json["itemStatus"] ?? "",
      color: json["color"] ?? "",
      phone: json["phone"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
      location: json["location"] ?? "",
      desc: json["desc"] ?? "",
      photos: List<String>.from(
          json["photos"] ?? []), // Ensure the photos array is parsed correctly
      ownerId: json["ownerId"] ?? "",
      postOwner: PostOwner.fromJson(json["postOwner"] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Post { id: $id, item: $item, itemStatus: $itemStatus, color: $color, phone: $phone, date: $date, time: $time, location: $location, desc: $desc, photos: $photos, ownerId: $ownerId, postOwner: $postOwner }';
  }
}

class PostOwner {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;

  PostOwner({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  factory PostOwner.fromJson(Map<String, dynamic> json) {
    return PostOwner(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      displayName: json["displayName"] ?? "",
      photoURL: json["photoURL"] ?? "",
    );
  }

  @override
  String toString() {
    return 'PostOwner { id: $id, email: $email, displayName: $displayName, photoURL: $photoURL }';
  }
}
