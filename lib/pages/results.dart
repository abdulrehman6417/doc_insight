import 'package:doc_insight/components/bottom_button.dart';
import 'package:doc_insight/components/card_container.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

void main() => runApp(ResultScreen());

class ResultScreen extends StatelessWidget {
  ResultScreen({this.calculation, this.description, this.result});
  final String? calculation;
  final String? result;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const ImageIcon(
            AssetImage('assets/images/back.png'),
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Your Result',
                style: kResultTitleText,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: ContainCard(
              clr: kActiveColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    result!.toUpperCase(),
                    style: kBmiText,
                  ),
                  Text(
                    calculation!,
                    style: kBmiNumber,
                  ),
                  Text(
                    description!,
                    style: kBmiDesc,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            bottomButtonText: 'Re-Calculate',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
