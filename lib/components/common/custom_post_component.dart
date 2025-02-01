import 'package:flutter/material.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class CustomPostComponent extends StatefulWidget {
  const CustomPostComponent({super.key});

  @override
  State<CustomPostComponent> createState() => _CustomPostComponentState();
}

class _CustomPostComponentState extends State<CustomPostComponent> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22, // Size of the circle avatar
                    backgroundImage: NetworkImage(
                      "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Haruto Tanaka",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Found in a classroom on C1/313",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                  onSelected: handleMenuSelection,
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: 'resolve',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Resolve',
                                  style: TextStyle(color: Colors.green),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                )
                              ],
                            )),
                        const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )
                              ],
                            ))
                      ])
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Message",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copy,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Copy Link",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "I found this MacBook in the classroom C1/313. If you are the owner or friend with owner...see more",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "10 minutes ago",
              style: TextStyle(fontSize: 14, color: AppColor.theme.hintColor),
            )
          ])
        ],
      ),
    );
  }
}
