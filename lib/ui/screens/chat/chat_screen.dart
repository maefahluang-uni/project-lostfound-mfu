import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lost_found_mfu/components/chat/chat_bar.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/helpers/chat_api_helper.dart';
import 'package:lost_found_mfu/models/chat.dart';
import 'dart:async';

import 'package:lost_found_mfu/services/socket_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatsSearchController = TextEditingController();
  List<ChatRoom> chatRooms = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _debounce;
  late SocketService socketService;

  @override
  void initState() {
    super.initState();
    socketService = SocketService();
  _initializeSocketAndFetchRooms();
    socketService.listenForRefresh((roomId) {
        fetchChatRooms(loadingRequired: false);
    });

    _chatsSearchController.addListener(_onSearchChanged);
  }

  Future<void> fetchChatRooms({String? searchQuery, bool? loadingRequired}) async {
    try {
      if(loadingRequired!){
        setState(() {
          isLoading = true;
        });
      }

      List<ChatRoom> fetchedRooms = await ChatApiHelper.getChatRooms(searchQuery: searchQuery);
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

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchChatRooms(searchQuery: _chatsSearchController.text.trim());
    });
  }
  Future<void> joinAllChatRooms(List<ChatRoom> chatRooms, SocketService socketService) async{
    for (ChatRoom room in chatRooms) {
      if (room.id != null) {
        socketService.joinRoom(room.id!);
      }
    }
  }
  Future<void> _initializeSocketAndFetchRooms() async {

    await fetchChatRooms(loadingRequired: true); 
    print("Fetching chat rooms completed. Joining rooms...");

    await joinAllChatRooms(chatRooms, socketService); 
  }
    @override
  void dispose() {
    _chatsSearchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Chats", hasBackArrow: false),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CustomTextField(
              controller: _chatsSearchController,
              label: "Search chats",
              prefixIcon: Icons.search,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) 
                : chatRooms.isEmpty
                    ? const Center(child: Text("No chats found")) 
                    : ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          final chatRoom = chatRooms[index];
                          print('chatRoomDate ${chatRoom?.lastMessage?.createdAt} ');
                          return ChatBar(
                            chatRoomId: chatRoom.id ?? '',
                            chatOwner: chatRoom.chatProfile?.fullName ?? "",
                            messagePreview: chatRoom.lastMessage?.content ?? "No messages yet",
                            messageCount: chatRoom.unreadCount,
                            messageTime: chatRoom.lastMessage?.createdAt != null
                                ? Jiffy.parse(chatRoom.lastMessage?.createdAt ?? "").format(pattern: "hh:mm a")
                                : '',
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
