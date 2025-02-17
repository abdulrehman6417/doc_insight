import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String leadingImagePath;
  final String cardTitle;
  final void Function()? onTap;
  const SettingsCard({
    super.key,
    required this.leadingImagePath,
    required this.cardTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: ListTile(
              leading: Image.asset(
                'assets/images/$leadingImagePath.png',
                height: 35.0,
                color: primaryBlue,
              ),
              title: Text(
                cardTitle,
                style: const TextStyle(
                  fontSize: 21.0,
                  letterSpacing: 0.5,
                  fontFamily: 'Poppins',
                ),
              ),
              trailing: Image.asset(
                'assets/images/next.png',
                height: 25.0,
                color: primaryBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
