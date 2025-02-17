import 'package:doc_insight/screens/about_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        toolbarHeight: 80,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20, width: double.infinity),
              const Text(
                'Help & Support',
                style: TextStyle(
                  fontFamily: 'InterBold',
                  fontSize: 24,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'ABOUT',
                    style: TextStyle(
                      color: Color(0xff5A5858),
                      fontFamily: 'InterBold',
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: primaryBlue,
                height: 15,
                thickness: 3,
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to the Help Page of DocInsight! Here, you\'ll find detailed instructions on how to use our app\'s key features: Symptom Check, Medicine Information, and BMI Calculation.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: itemsColor,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'SYMPTOM CHECK',
                    style: TextStyle(
                      color: Color(0xff5A5858),
                      fontFamily: 'InterBold',
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: primaryBlue,
                height: 15,
                thickness: 3,
              ),
              const SizedBox(height: 8),
              Text(
                'Step-by-Step Guide to Using Symptom Check:',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: itemsColor,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    KeyPoint(
                      heading: 'Open the Symptom Check Tab: ',
                      description:
                          'Navigate to the Symptom Check tab from the main menu.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Enter Symptoms: ',
                      description:
                          'Enter your symptoms in the provided text fields. You can add multiple symptoms by clicking the "Add more" button.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Provide Additional Details: ',
                      description:
                          'Fill in your age, gender, and region to ensure personalized and accurate results.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Submit Symptoms: ',
                      description:
                          'Click on the "Submit" button to receive potential causes and health insights related to your symptoms.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'View Results: ',
                      description:
                          'Review the personalized health insights provided by our AI. You can take further action based on the recommendations.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'MEDICINE INFORMATION',
                    style: TextStyle(
                      color: Color(0xff5A5858),
                      fontFamily: 'InterBold',
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: primaryBlue,
                height: 15,
                thickness: 3,
              ),
              const SizedBox(height: 8),
              Text(
                'Step-by-Step Guide to Using Medicine Information:',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: itemsColor,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    KeyPoint(
                      heading: 'Open the Medicine Information Tab: ',
                      description:
                          'Navigate to the Medicine Information tab from the main menu.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Enter Medicine Name: ',
                      description:
                          'Type the name of the medicine you want to learn about in the text field.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Submit Your Query: ',
                      description:
                          'Click the "Submit" button to retrieve detailed information about the medicine.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Review Information:  ',
                      description:
                          'View detailed information including working, functionality and more. This information will help you understand how to use the medicine safely and effectively.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'BMI CALCULATION',
                    style: TextStyle(
                      color: Color(0xff5A5858),
                      fontFamily: 'InterBold',
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: primaryBlue,
                height: 15,
                thickness: 3,
              ),
              const SizedBox(height: 8),
              Text(
                'Step-by-Step Guide to Using BMI Calculation:',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: itemsColor,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    KeyPoint(
                      heading: 'Open the BMI Calculator Tab:: ',
                      description:
                          'Navigate to the BMI Calculator tab from the main menu.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Enter Your Details: ',
                      description:
                          'Provide your height, weight, age and gender in the respective fields.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Calculate BMI: ',
                      description:
                          'Provide your height, weight, age and gender in the respective fields.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'View Results: ',
                      description:
                          'Review your BMI results. The app will provide you with insights into what your BMI means for your health and suggest any necessary actions you might consider.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
