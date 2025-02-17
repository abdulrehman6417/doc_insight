import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doc_insight/components/card_container.dart';
import 'package:doc_insight/components/icon_info.dart';
import 'package:doc_insight/constants.dart';
import 'package:doc_insight/pages/results.dart';
import 'package:doc_insight/components/bottom_button.dart';
import 'package:doc_insight/components/rounded_btn.dart';
import 'package:doc_insight/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? userGender;
  int height = 140;
  int weight = 60;
  int age = 18;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ContainCard(
                    onPress: () {
                      setState(() {
                        userGender = Gender.male;
                      });
                    },
                    clr: userGender == Gender.male
                        ? kActiveColor
                        : kInActiveColor,
                    cardChild: IconInfo(
                      mainIcon: FontAwesomeIcons.mars,
                      iconClr: Colors.blue,
                      gender: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ContainCard(
                    onPress: () {
                      setState(() {
                        userGender = Gender.female;
                      });
                    },
                    clr: userGender == Gender.female
                        ? kActiveColor
                        : kInActiveColor,
                    cardChild: IconInfo(
                      mainIcon: FontAwesomeIcons.venus,
                      iconClr: Colors.pink,
                      gender: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ContainCard(
              clr: kActiveColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HEIGHT',
                    style: kContainerText,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        height.toString(),
                        style: kNumTextStyle,
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'cm',
                        style: kContainerText,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: primaryBlue,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 16.0),
                      activeTrackColor: primaryBlue,
                      inactiveTrackColor: const Color(0xFF8D8E98),
                      overlayColor: const Color(0x1FEB1555),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                      // activeColor: Color(0xFFEB1555),
                      // activeColor: Colors.white,
                      // inactiveColor: Color(0xFF8D8E98),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ContainCard(
                    clr: kActiveColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'WEIGHT',
                          style: kContainerText,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumTextStyle,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIconButton(
                              icon: FontAwesomeIcons.minus,
                              btnPress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            RoundedIconButton(
                              icon: FontAwesomeIcons.plus,
                              btnPress: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ContainCard(
                    clr: kActiveColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'AGE',
                          style: kContainerText,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          age.toString(),
                          style: kNumTextStyle,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIconButton(
                              icon: FontAwesomeIcons.minus,
                              btnPress: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            RoundedIconButton(
                              icon: FontAwesomeIcons.plus,
                              btnPress: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            bottomButtonText: 'Calculate Your BMI',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(weight: weight, height: height);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultScreen(
                          calculation: calc.bmiCalculation(),
                          result: calc.getResult(),
                          description: calc.getDesc(),
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
