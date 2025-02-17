import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key, required this.chatMessage, required this.chatIndex});

  final String chatMessage;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.red,
                    image: DecorationImage(
                      image: chatIndex == 0
                          ? const AssetImage('assets/images/profile.jpg')
                          : const AssetImage('assets/images/openAI.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: chatIndex == 0
                      ? Text(
                          chatMessage,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1.0,
                            height: 1.5,
                          ),
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1.0,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 0,
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText(
                                chatMessage.trim(),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        chatIndex == 0
            ? const SizedBox.shrink()
            : Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.thumb_down_alt_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
