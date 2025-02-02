import 'dart:convert';

PostItem PostItemFromJson(String str) => PostItem.fromJson(json.decode(str));

String PostItemToJson(PostItem data) => json.encode(data.toJson());

class PostItem {
  List<Item> items;

  PostItem({
    required this.items,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  String item;
  String status;
  String color;
  DateTime date;
  String time;
  String location;
  String phoneNumber;
  String description;
  List<String> images;

  Item({
    required this.id,
    required this.item,
    required this.status,
    required this.color,
    required this.date,
    required this.time,
    required this.location,
    required this.phoneNumber,
    required this.description,
    required this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        item: json["item"],
        status: json["status"],
        color: json["color"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        location: json["location"],
        phoneNumber: json["phone_number"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "status": status,
        "color": color,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "location": location,
        "phone_number": phoneNumber,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
