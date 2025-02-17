import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class UserGuideTextBlock extends StatelessWidget {
  final String title;
  const UserGuideTextBlock({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color1LightBlue,
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.only(top: 10.0, left: 17, right: 17),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Gothic',
            color: Colors.white,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
