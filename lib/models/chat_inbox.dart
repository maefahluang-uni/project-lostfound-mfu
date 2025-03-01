class ChatInbox {
  String? id;
  SenderProfile? senderProfile;
  List<ChatRoomMessages>? chatRoomMessages;

  ChatInbox({this.id, this.senderProfile, this.chatRoomMessages});

  ChatInbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderProfile = json['senderProfile'] != null
        ? new SenderProfile.fromJson(json['senderProfile'])
        : null;
    if (json['chatRoomMessages'] != null) {
      chatRoomMessages = <ChatRoomMessages>[];
      json['chatRoomMessages'].forEach((v) {
        chatRoomMessages!.add(new ChatRoomMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.senderProfile != null) {
      data['senderProfile'] = this.senderProfile!.toJson();
    }
    if (this.chatRoomMessages != null) {
      data['chatRoomMessages'] =
          this.chatRoomMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SenderProfile {
  String? email;
  String? fullName;

  SenderProfile({this.email, this.fullName});

  SenderProfile.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    return data;
  }
}

class ChatRoomMessages {
  String? id;
  String? type;
  String? senderId;
  String? content;
  String? attachmentUrl;
  String? roomId;
  String? createdAt;

  ChatRoomMessages(
      {this.id,
      this.type,
      this.senderId,
      this.content,
      this.attachmentUrl,
      this.roomId,
      this.createdAt});

  ChatRoomMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    senderId = json['sender_id'];
    content = json['content'];
    attachmentUrl = json['attachmentUrl'];
    roomId = json['room_id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['sender_id'] = this.senderId;
    data['content'] = this.content;
    data['attachmentUrl'] = this.attachmentUrl;
    data['room_id'] = this.roomId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}