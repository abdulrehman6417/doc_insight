import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class TopBar2 extends StatefulWidget {
  const TopBar2({
    super.key,
  });

  @override
  State<TopBar2> createState() => _TopBar2State();
}

class _TopBar2State extends State<TopBar2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryBlue,
        border: Border(bottom: BorderSide(color: itemsColor, width: 2)),
      ),
      padding: const EdgeInsets.only(left: 20, top: 45, bottom: 15, right: 10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Results',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'DocInsight',
            style: TextStyle(
              fontFamily: 'Request',
              fontSize: 10,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
