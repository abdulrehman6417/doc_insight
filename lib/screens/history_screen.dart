import 'package:doc_insight/tab_items/tab_item1.dart';
import 'package:doc_insight/tab_items/tab_item2.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/top_bar3.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: secondaryWhite,
        appBar: const TopBar3(
          pageTitle: 'History',
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: primaryBlue,
              indicatorWeight: 5,
              tabs: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Symptoms',
                    style: TextStyle(
                      color: itemsColor,
                      fontFamily: 'InterBold',
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Drugs',
                    style: TextStyle(
                      color: itemsColor,
                      fontFamily: 'InterBold',
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  TabItem1(),
                  TabItem2(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
