import 'package:doc_insight/services/firebase_services.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/history_tiles2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabItem2 extends StatefulWidget {
  const TabItem2({super.key});

  @override
  State<TabItem2> createState() => _TabItem2State();
}

class _TabItem2State extends State<TabItem2> {
  //getting the current user id to store data
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //creating reference to class Firebase Services
  final firestoreService = FirestoreServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreService.getSymptomCheckHistory(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: firestoreService.getMedicineInfoHistory(currentUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.28,
                    ),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: primaryBlue,
                    )),
                  ); // Show loading indicator while fetching data
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final history = snapshot.data ?? [];
                return (history.isEmpty)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.28,
                        ),
                        child: Center(
                          child: Text(
                            'No History to Show',
                            style: TextStyle(
                              color: itemsColor.withOpacity(0.5),
                              fontFamily: 'Inter',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final item = history[index];
                            return HistoryTiles2(
                                medicineName: item['medicine_name'],
                                response: item['response'],
                                timestamp: item['timestamp']);
                          },
                        ),
                      );
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Image.asset(
                  'assets/images/clean.png',
                  height: 40.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
