import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lost_found_mfu/components/chat/chat_inbox/chat_bubble.dart';
import 'package:lost_found_mfu/components/chat/chat_inbox/chat_input.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/helpers/chat_api_helper.dart';
import 'package:lost_found_mfu/models/chat_inbox.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatInboxScreen extends StatefulWidget {
  final String chatRoomId;

  const ChatInboxScreen({super.key, required this.chatRoomId});

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  XFile? _selectedImage;
  ChatInbox? chatRoom;
  bool isLoading = true;
  String? errorMessage;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    initUserData();
  }

  Future<void> initUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId');
    });
    fetchChatRooms();
  }

  Future<void> fetchChatRooms() async {
    try {
      ChatInbox? fetchedRoom = await ChatApiHelper.getChatRoom(widget.chatRoomId);
      setState(() {
        chatRoom = fetchedRoom;
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
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        appBarTitle: chatRoom?.senderProfile?.fullName ?? "Chat",
        hasBackArrow: true,
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: AppColor.chatBackground),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator()) 
                  : (chatRoom?.chatRoomMessages?.isEmpty ?? true)
                      ? const Center(child: Text("No messages yet")) 
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          itemCount: chatRoom?.chatRoomMessages?.length ?? 0, 
                          itemBuilder: (context, index) {
                            final message = chatRoom!.chatRoomMessages![index];
                            bool isSelf = message.senderId == currentUserId; 
                            String messageDate = Jiffy.parse(message.createdAt!).format(pattern: 'dd MMM yyyy');
                            String? previousMessageDate = index > 0
                                ? Jiffy.parse(chatRoom!.chatRoomMessages![index - 1].createdAt!).format(pattern: 'dd MMM yyyy')
                                : null;
                            bool showDateHeader = (previousMessageDate == null || previousMessageDate != messageDate);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (showDateHeader)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "$messageDate",
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                Align(
                                  alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
                                  child: ChatBubble(
                                    messageType: message.type ?? 'text',
                                    isSelf: isSelf,
                                    messageContent: message.content,
                                    messageTime: Jiffy.parse(message.createdAt!).format(pattern: 'HH:mm a'),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
            ),
          ),

          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: ChatInput(
              onImagePicked: (XFile? selectedImage) {
                setState(() {
                  _selectedImage = selectedImage;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
