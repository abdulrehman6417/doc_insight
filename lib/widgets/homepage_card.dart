import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  final String cardName;
  final String cardIconPath;
  final Function()? onTap;
  final double horizontalPadding;
  const HomePageCard({
    super.key,
    required this.cardName,
    required this.cardIconPath,
    required this.onTap,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color2DarkBlue,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: color2DarkBlue,
              offset: const Offset(1, 1),
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 25),
        child: Column(
          children: [
            Image.asset(
              'assets/images/$cardIconPath.png',
              width: 60.0,
              height: 60.0,
            ),
            const SizedBox(height: 15.0),
            Text(
              cardName,
              style: const TextStyle(
                fontFamily: 'Gothic',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
