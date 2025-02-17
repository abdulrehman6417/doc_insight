class ChatModel {
  String? msg;
  int? chatIndex;
  ChatModel({required this.msg, required this.chatIndex});

  ChatModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    chatIndex = json['chatIndex'];
  }
}
