import 'package:flutter/material.dart';
import 'package:lost_found_mfu/ui/screens/chat/chat_inbox/chat_inbox_screen.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatBar extends StatelessWidget {
  const ChatBar(
      {super.key,
      required this.chatOwner,
      required this.messagePreview,
      this.messageCount,
      required this.messageTime,
      required this.chatRoomId,
      });
  final String chatOwner;
  final String messagePreview;
  final int? messageCount;
  final String messageTime;
  final String chatRoomId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ChatInboxScreen(chatRoomId: this.chatRoomId))
        );
      },
      child: Container(
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
                  messageCount! > 0 ? Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.theme.primaryColor),
                    child: Text(messageCount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)) ,
                  ) : SizedBox(),
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
      ),
    );
  }
}
