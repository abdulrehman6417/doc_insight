import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTiles extends StatelessWidget {
  final List symptoms;
  final String response;
  final Timestamp timestamp;
  const HistoryTiles({
    super.key,
    required this.symptoms,
    required this.response,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM, yy').format(timestamp.toDate());
    String formattedTime = DateFormat('h:mm a').format(timestamp.toDate());
    // Get today's date
    DateTime today = DateTime.now();
    String todayDate = DateFormat('dd MMM, yy').format(today);
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryBlue, width: 2.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: ClipRRect(
        child: ListTile(
          title: Text(
            symptoms.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              color: primaryBlue,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          subtitle: Text(
            response.toString(),
            style: TextStyle(
              fontFamily: 'Gothic',
              color: itemsColor,
              fontSize: 14.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Column(
            children: [
              Text(
                formattedDate == todayDate ? 'Today' : formattedDate,
                style: TextStyle(
                  color: itemsColor,
                  fontFamily: 'PoppinsBold',
                  fontSize: 16,
                ),
              ),
              Text(
                formattedTime,
                style: const TextStyle(
                  fontFamily: 'Gothic',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Row(
      //   children: [
      //     Expanded(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Health Info',
      //             style: TextStyle(
      //               fontFamily: 'Poppins',
      //               color: primaryBlue,
      //               fontSize: 20.0,
      //               fontWeight: FontWeight.bold,
      //               letterSpacing: 1.0,
      //             ),
      //           ),
      //           const SizedBox(height: 3.0),
      //           const Text(
      //             maxLines: 2,
      //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      //             style: TextStyle(
      //               fontFamily: 'Gothic',
      //               color: Color.fromARGB(255, 25, 24, 79),
      //               fontSize: 13.0,
      //               letterSpacing: 1.5,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ],
      //       ),

      //     ),
      //   ],
      // ),
    );
  }
}
