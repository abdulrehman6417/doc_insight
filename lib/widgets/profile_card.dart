import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String cardTitle;
  final String cardData;
  final TextStyle dataTextStyle;
  final void Function()? onTap;
  const ProfileCard({
    super.key,
    required this.cardTitle,
    required this.cardData,
    required this.dataTextStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardTitle,
                    style: TextStyle(
                      color:
                          const Color.fromARGB(255, 2, 7, 34).withOpacity(0.5),
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 330.0,
                    child: Text(
                      cardData,
                      style: dataTextStyle,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/pen.png',
                  width: 25.0,
                  fit: BoxFit.cover,
                  color: itemsColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
