import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isSelf, required this.messageType, this.messageImage});
  final bool isSelf;
  final String messageType;
  final XFile? messageImage;

  Widget generateMessage(){
    switch (messageType){
      case "text":
        return isSelf ? 
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("12:39PM", style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.left,),
                      Container(
                        constraints: BoxConstraints(minWidth:100, maxWidth: 300),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryRed,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft:Radius.circular(10), bottomLeft: Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:11, top:13, right:11, bottom: 13),
                          child: Text("Thank you! Thank you!Thank you!Thank you!Thank you!Thank you!Thank you!Thank you!Thank you!Thank you!", 
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ]
                  ),
                )
                : 
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("12:39PM", style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.right,),
                      Container(
                        constraints: BoxConstraints(minWidth:100, maxWidth: 300),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft:Radius.circular(10), bottomRight: Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:11, top:13, right:11, bottom: 13),
                          child: Text("Thank you!", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                      ),
                    ]
                  ),
                );
      case "image":
        return isSelf ?
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text("12:39PM", style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.right,),
            SizedBox(
              height:192,
              width: 227,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft:Radius.circular(10), bottomLeft: Radius.circular(10)),
                child: messageImage != null ? Image.file(File(messageImage!.path), fit: BoxFit.cover) : Image.network('https://i.ebayimg.com/images/g/RgsAAOSwtqFk1su0/s-l1200.jpg', fit: BoxFit.cover)
                ),
            ),
            ]
          ),
        )
        :
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text("12:39PM", style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.right,),
            SizedBox(
              height:192,
              width: 227,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft:Radius.circular(10), bottomRight: Radius.circular(10)),
                child: messageImage != null ? Image.file(File(messageImage!.path), fit: BoxFit.cover) : Image.network('https://i.ebayimg.com/images/g/RgsAAOSwtqFk1su0/s-l1200.jpg', fit: BoxFit.cover)),
            ),
            ]
          ),
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 21, bottom: 13), child: generateMessage());
}}