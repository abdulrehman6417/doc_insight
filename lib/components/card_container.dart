import 'package:flutter/material.dart';

class ContainCard extends StatelessWidget {
  ContainCard({required this.clr, this.cardChild, this.onPress});

  final Color clr;
  final Widget? cardChild;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: clr,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: cardChild,
      ),
    );
  }
}
