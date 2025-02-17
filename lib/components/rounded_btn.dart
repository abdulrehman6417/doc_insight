import 'package:flutter/material.dart';
// import 'package:bmi_calc/constants.dart';

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({this.icon, this.btnPress});
  final IconData? icon;
  final Function()? btnPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      onPressed: btnPress,
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color.fromARGB(255, 164, 166, 169),
      child: Icon(icon),
    );
  }
}
