class ChatRoom {
  String? id;
  LastMessage? lastMessage;
  int? unreadCount;
  ChatProfile? chatProfile;
  String? user1Id;
  String? user2Id;
  Timestamp? timestamp;

  ChatRoom(
      {this.id,
      this.lastMessage,
      this.unreadCount,
      this.chatProfile,
      this.user1Id,
      this.user2Id,
      this.timestamp});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    unreadCount = json['unread_count'];
    chatProfile = json['chatProfile'] != null
        ? new ChatProfile.fromJson(json['chatProfile'])
        : null;
    user1Id = json['user_1_id'];
    user2Id = json['user_2_id'];
    timestamp = json['timestamp'] != null
        ? new Timestamp.fromJson(json['timestamp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['unread_count'] = this.unreadCount;
    if (this.chatProfile != null) {
      data['chatProfile'] = this.chatProfile!.toJson();
    }
    data['user_1_id'] = this.user1Id;
    data['user_2_id'] = this.user2Id;
    if (this.timestamp != null) {
      data['timestamp'] = this.timestamp!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? messageType;
  String? content;
  String? createdAt;

  LastMessage({this.messageType, this.content, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    content = json['content'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageType'] = this.messageType;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class ChatProfile {
  String? id;
  String? fullName;

  ChatProfile({this.id, this.fullName});

  ChatProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    return data;
  }
}

class Timestamp {
  int? iSeconds;
  int? iNanoseconds;

  Timestamp({this.iSeconds, this.iNanoseconds});

  Timestamp.fromJson(Map<String, dynamic> json) {
    iSeconds = json['_seconds'];
    iNanoseconds = json['_nanoseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_seconds'] = this.iSeconds;
    data['_nanoseconds'] = this.iNanoseconds;
    return data;
  }
}