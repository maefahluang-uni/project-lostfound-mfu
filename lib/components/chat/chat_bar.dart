import 'package:flutter/material.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatBar extends StatelessWidget {
  const ChatBar(
      {super.key,
      required this.chatOwner,
      required this.messagePreview,
      required this.messageCount,
      required this.messageTime});
  final String chatOwner;
  final String messagePreview;
  final String messageCount;
  final String messageTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: AppColor.theme.dividerColor, width: 1))),
      height: 89,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 22),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                      child: Image.network(
                    "https://thumbs.dreamstime.com/b/portrait-lego-man-minifigure-against-gray-baseplate-tambov-russian-federation-october-studio-shot-167467396.jpg",
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatOwner,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    messagePreview,
                    style: TextStyle(
                        color: AppColor.theme.hintColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.theme.primaryColor),
                  child: Text(messageCount,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
                Text(messageTime,
                    style: TextStyle(
                        color: AppColor.theme.hintColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}
