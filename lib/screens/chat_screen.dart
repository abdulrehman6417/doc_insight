import 'package:doc_insight/api_service.dart';
import 'package:doc_insight/providers/chat_provider.dart';
import 'package:doc_insight/providers/models_provider.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/bottomSheet.dart';
import 'package:doc_insight/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController controller;
  bool isTyping = false;
  late FocusNode focusNode;
  late ScrollController _listScroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
    ApiService.getModels();
    _listScroller = ScrollController();
  }

  // List<ChatModel> chatList = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
    controller.dispose();
    _listScroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
          children: [
            Text('DocInsight', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10.0),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: IconButton(
              onPressed: () async {
                await ModalSheetBottom.showModalSheet(context: context);
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                chatProvider.getChatList.isEmpty
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: const Center(
                            child: Text(
                              'DocInsight',
                              style: TextStyle(
                                color: Color.fromARGB(253, 158, 158, 158),
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: ListView.builder(
                            controller: _listScroller,
                            physics: const BouncingScrollPhysics(),
                            itemCount: chatProvider
                                .getChatList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ChatWidget(
                                  chatMessage:
                                      chatProvider.getChatList[index].msg!,
                                  chatIndex: chatProvider
                                      .getChatList[index].chatIndex!,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                if (isTyping) ...[
                  const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 18,
                  ),
                ],
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            maxLines: null,
                            style: const TextStyle(
                                color: Colors.white, height: 1.5),
                            controller: controller,
                            onSubmitted: (value) async {
                              await sendMessageFunc(
                                modelsProvider: modelsProvider,
                                chatProvider: chatProvider,
                              );
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Ask anything...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await sendMessageFunc(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider,
                            );
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _listScroller.animateTo(
      _listScroller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessageFunc(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please type something',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msgText = controller.text;
      setState(() {
        isTyping = true;
        //chatList.add(ChatModel(msg: controller.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msgText);
        controller.clear();
        focusNode.unfocus();
      });
      // chatList.addAll(await ApiService.sendMessage(
      //   message: controller.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      await chatProvider.sendMessageAndGetAnswer(
        msg: msgText,
        choosenModelId: modelsProvider.getCurrentModel,
      );
      setState(() {});
    } catch (error) {
      print("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$error',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isTyping = false;
        scrollListToEnd();
      });
    }
  }
}
