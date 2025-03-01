import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lost_found_mfu/components/chat/chat_bar.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/chat_api_helper.dart';
import 'package:lost_found_mfu/models/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState(){
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _ChatsSearchController = TextEditingController();
  List<ChatRoom> chatRooms = [];
  bool isLoading = true;
  String? errorMessage;
  
  @override
  void initState() {
    super.initState();
    fetchChatRooms(); 
  }

  Future<void> fetchChatRooms() async {
    try {
      List<ChatRoom> fetchedRooms = await ChatApiHelper.getChatRooms();
      setState(() {
        chatRooms = fetchedRooms;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Error fetching chat rooms: $error";
        isLoading = false;
      });
    }
  }

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
          Expanded(
            child: chatRooms.isEmpty ? Text("No chats found") :
            ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                return
                  ChatBar(
                    chatRoomId: chatRoom.id ?? '',
                    chatOwner: chatRoom.chatProfile?.fullName ?? "",
                    messagePreview: chatRoom.lastMessage?.content ?? "No messages yet",
                    messageCount: "3",
                    messageTime:  chatRoom.lastMessage?.createdAt != null ? Jiffy.parse(chatRoom.lastMessage?.createdAt ?? "").format(pattern: 'HH:mm a') : '',
                  );
              },
            ),
          )
        ],
      )
    );
  }
}