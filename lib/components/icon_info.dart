import 'package:flutter/material.dart';
import 'package:doc_insight/constants.dart';

class IconInfo extends StatelessWidget {
  IconInfo({required this.mainIcon, this.iconClr, required this.gender});

  final IconData mainIcon;
  final Color? iconClr;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          mainIcon,
          size: 80.0,
          color: iconClr,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          gender,
          style: kContainerText,
        ),
      ],
    );
  }
}
