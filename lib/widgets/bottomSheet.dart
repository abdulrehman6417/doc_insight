import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class ModalSheetBottom {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        backgroundColor: scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Choose Model:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Expanded(
                  child: ModalDropDown(),
                ),
              ],
            ),
          );
        });
  }
}
