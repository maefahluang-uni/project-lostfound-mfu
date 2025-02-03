import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/chat/chat_inbox/chat_bubble.dart';
import 'package:lost_found_mfu/components/chat/chat_inbox/chat_input.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatInboxScreen extends StatefulWidget {
  ChatInboxScreen({super.key});

  @override
  State<ChatInboxScreen> createState(){
    return _ChatInboxScreenState();
  }
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
    XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(appBarTitle: "Khant Nyar Htet Aung", hasBackArrow: true,),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 700,
            decoration: BoxDecoration(
              color: AppColor.chatBackground
            ),
            child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: 25, right: 25),
            children: [
              Align(alignment: Alignment.centerLeft, child: ChatBubble(messageType:"text", isSelf: false,)),
              Align(alignment: Alignment.centerRight, child:  ChatBubble(messageType:"text", isSelf: true,)),
              Align(alignment: Alignment.centerRight, child:  ChatBubble(messageType:"image", isSelf: true,messageImage: _selectedImage,)),
              Align(alignment: Alignment.centerLeft, child: ChatBubble(messageType:"text", isSelf: false,)),
              Align(alignment: Alignment.centerLeft, child: ChatBubble(messageType:"image", isSelf: false,messageImage: _selectedImage,)),
              Align(alignment: Alignment.centerRight, child:  ChatBubble(messageType:"image", isSelf: true,messageImage: _selectedImage,)),
              Align(alignment: Alignment.centerLeft, child: ChatBubble(messageType:"text", isSelf: false,)),
              Align(alignment: Alignment.centerLeft, child: ChatBubble(messageType:"image", isSelf: false,messageImage: _selectedImage,)),
            ],),
          ),
          Expanded(
            child: ChatInput(
              onImagePicked: (XFile? selectedImage) => {
                setState(() {
                  _selectedImage = selectedImage;
                })
              },
            )
          )
        ],
      )
    );
  }
}