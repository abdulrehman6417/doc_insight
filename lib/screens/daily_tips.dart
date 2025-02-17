import 'dart:math';

import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DailyHealthTips extends StatefulWidget {
  const DailyHealthTips({super.key});

  @override
  State<DailyHealthTips> createState() => _DailyHealthTipsState();
}

class _DailyHealthTipsState extends State<DailyHealthTips> {
  List<String> tips = [
    "Drink water regularly throughout the day.",
    "Eat a variety of colorful fruits and vegetables.",
    "Include lean protein sources in your meals, such as chicken, fish, tofu, or legumes.",
    "Choose whole grains over refined grains for better nutrition.",
    "Limit processed foods and snacks high in added sugars and unhealthy fats.",
    "Practice portion control to avoid overeating.",
    "Eat mindfully, paying attention to hunger and fullness cues.",
    "Incorporate healthy fats like avocados, nuts, and olive oil into your diet.",
    "Include fiber-rich foods like beans, lentils, fruits, and vegetables for better digestion.",
    "Limit sodium intake by cooking at home and avoiding processed foods.",
    "Choose low-fat or fat-free dairy products for calcium and vitamin D.",
    "Snack on fresh fruits, vegetables, or nuts for a nutritious boost.",
    "Prepare meals at home to control ingredients and portion sizes.",
    "Limit consumption of sugary beverages like soda and fruit juice.",
    "Focus on whole, natural foods rather than processed or packaged options.",
    "Plan meals ahead of time to make healthier choices.",
    "Experiment with herbs and spices to flavor food instead of salt.",
    "Read food labels to make informed choices about ingredients and nutrients.",
    "Incorporate fermented foods like yogurt, kefir, and sauerkraut for gut health.",
    "Limit consumption of red and processed meats for heart health.",
    "Choose snacks that combine protein and fiber for sustained energy.",
    "Eat breakfast to kickstart your metabolism and fuel your day.",
    "Limit intake of fast food and restaurant meals high in calories and unhealthy fats.",
    "Cook with healthy cooking methods like baking, grilling, steaming, or sautéing.",
    "Keep healthy snacks readily available to avoid reaching for unhealthy options.",
    "Incorporate plant-based meals like salads, soups, and stir-fries into your diet.",
    "Avoid skipping meals, which can lead to overeating later in the day.",
  ];

  int currentIndex = Random().nextInt(3);

  void nextTip() {
    setState(() {
      currentIndex = (currentIndex + 1) % tips.length;
    });
  }

  void previousTip() {
    setState(() {
      currentIndex = (currentIndex - 1 + tips.length) % tips.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: const TopBar(pageTitle: 'Daily Health Tips'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Container(
            child: Lottie.asset(
              'assets/animations/tips.json',
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: primaryBlue,
            ),
            child: Text(
              tips[currentIndex],
              style: TextStyle(
                  fontSize: 32, color: secondaryWhite, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: previousTip,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: primaryBlue,
                          size: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: primaryBlue,
                            fontFamily: 'InterBold',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: nextTip,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'InterBold',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: secondaryWhite,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
