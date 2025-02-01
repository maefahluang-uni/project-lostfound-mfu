import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/chat/chat_bar.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState(){
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _ChatsSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Chats", hasBackArrow: false),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:25, right:25),
            child: CustomTextField(controller: _ChatsSearchController, label: "Search chats", prefixIcon: Icons.search,),
          ),
          ChatBar(
            chatOwner: "Khant Nyar Htet Aung",
            messagePreview: "Let's meet at M-square!",
            messageCount: "3",
            messageTime: "12:32PM",
          ),
          ChatBar(
            chatOwner: "La Yaung Chit",
            messagePreview: "Okay, I will be there!",
            messageCount: "2",
            messageTime: "01:22PM",
          ),
          ChatBar(
            chatOwner: "Thaung Than Han",
            messagePreview: "I will surely bring it tomorrow!",
            messageCount: "1",
            messageTime: "09:24AM",
          ),
        ],
      )
    );
  }
}