import 'dart:convert';
import 'dart:io';

import 'package:doc_insight/models/chat_model.dart';
import 'package:doc_insight/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String API_KEY = dotenv.env['SERVICE_API_KEY'].toString();

class ApiService {
  // Get the models here
  static List<ModelsModel> modelsList = [];
  static Future<List<ModelsModel>> getModels() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.openai.com/v1/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      final data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        for (var i in data) {
          ModelsModel model = ModelsModel.fromJson(i);
          modelsList.add(model);
        }
      } else {
        print(data['error']['message']);
      }
    } catch (error) {
      print("error $error");
    }
    return modelsList;
  }

  // Send Message

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": modelId,
          "messages": [
            {
              "role": "user",
              "content": message,
            },
          ]
        }),
      );

      final data = jsonDecode(response.body);

      if (data['error'] != null) {
        throw HttpException(data['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (data['choices'].isNotEmpty) {
        // print("text inside choices: ${data['choices'][0]['message']['content']}");
        chatList = List.generate(
          data['choices'].length,
          (index) => ChatModel(
            msg: data['choices'][0]['message']['content'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}
