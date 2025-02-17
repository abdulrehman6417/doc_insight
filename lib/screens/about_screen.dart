import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                'About DocInsight',
                style: TextStyle(
                  fontFamily: 'InterBold',
                  fontSize: 24,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Welcome to DocInsight',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: itemsColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'OUR MISSION',
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
                'At DocInsight, our mission is to empower individuals with accessible, reliable, and personalized health guidance. We strive to provide accurate and timely information to help you make informed decisions about your health and well-being.',
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
                    'WHAT WE DO',
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
                'DocInsight leverages the power of modern technology and AI to offer an intuitive platform where users can:',
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
                      heading: 'Check Symptoms: ',
                      description:
                          'Input your symptoms to receive personalized health insights and potential causes.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Learn About Medicines: ',
                      description:
                          'Get detailed information on various medicines, including usage, side effects, and interactions.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Monitor Health Metrics: ',
                      description:
                          'Calculate and track your Body Mass Index (BMI) and other health-related metrics.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Manage Profile: ',
                      description:
                          'Easily update your personal information to ensure accurate and tailored health advice.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Why Choose DocInsight?',
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    KeyPoint(
                      heading: 'User-Friendly Interface: ',
                      description:
                          'Our app is designed to be easy to use, even for those who are not tech-savvy.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Accurate Information: ',
                      description:
                          'We provide reliable and up-to-date health information powered by advanced AI technology.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Personalized Guidance: ',
                      description:
                          'Receive health advice tailored to your specific symptoms and health profile.',
                    ),
                    SizedBox(height: 15),
                    KeyPoint(
                      heading: 'Secure & Confidential:  ',
                      description:
                          'Your privacy is our priority. All your data is securely stored and confidentially managed.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'OUR VISION',
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
                'We envision a world where everyone has access to trustworthy health information and guidance, right at their fingertips. By continuously innovating and improving our platform, we aim to make a significant impact on global health and wellness.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: itemsColor,
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

class KeyPoint extends StatelessWidget {
  final String heading, description;
  const KeyPoint({
    super.key,
    required this.heading,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(100),
          ),
          height: 10,
          width: 10,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: heading,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: itemsColor,
                  fontSize: 17,
                ),
              ),
              TextSpan(
                text: description,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: itemsColor,
                  fontSize: 17,
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
