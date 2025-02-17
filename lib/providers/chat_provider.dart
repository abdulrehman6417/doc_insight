import 'package:doc_insight/api_service.dart';
import 'package:doc_insight/models/chat_model.dart';
// import 'package:chat_gpt/providers/models_provider.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer(
      {required String msg, required String choosenModelId}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelId: choosenModelId,
    ));
    notifyListeners();
  }
}
