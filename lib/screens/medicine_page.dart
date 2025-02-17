import 'dart:convert';

import 'package:doc_insight/screens/meds_response_page.dart';
import 'package:doc_insight/services/firebase_services.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:doc_insight/widgets/top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  //getting the current user id to store data
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //creating reference to class Firebase Services
  final firestoreService = FirestoreServices();

  final medicineController = TextEditingController();
  String API_KEY = dotenv.env['PAGE_API_KEY'].toString();
  bool isLoading = false;

  Future<String> fetchResponse(String userInput) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(
            'https://api.openai.com/v1/engines/gpt-3.5-turbo-instruct/completions'),
        headers: {
          'Authorization':
              'Bearer $API_KEY', // Replace with your actual API key
          'Content-Type': 'application/json',
        },
        body:
            '{"prompt": "There is this medicine named $userInput, what i want you to do is 1. Provide me with its functionality under the heading \'functionality\' under numbered bullet points 2. Provide me with its working under the heading \'Working\' under numbered bullet points and make the terminologies much more simpler and easier to understand for layman. make it much more brief and short.", "max_tokens": 400}',
      );

      if (response.statusCode == 200) {
        // Successful response
        final jsonResponse = jsonDecode(response.body);
        final finalResponse = jsonResponse['choices'][0]['text'];
        return finalResponse;
      } else {
        // Handle API errors
        print('API error: ${response.statusCode}');
        throw Exception('Failed to load response');
      }
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      print('Exception: $e');
      throw Exception('Failed to load response');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    medicineController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: const TopBar(pageTitle: 'Drugs Insight'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                child: Lottie.asset(
                  'assets/animations/meds.json',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Enter Drug/Medicine Name',
                style: TextStyle(
                  color: itemsColor,
                  fontFamily: 'InterBold',
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, -2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: medicineController,
                        decoration: InputDecoration(
                          label: const Text('-Medicine Name-'),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 152, 151, 151),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    RoundButton(
                      title: 'Submit',
                      onTap: () async {
                        String userInput = medicineController.text;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 50,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Please wait',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: primaryBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CircularProgressIndicator(
                                        color: primaryBlue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                        String response = await fetchResponse(userInput);
                        firestoreService.storeMedicineInfoHistory(
                            currentUserId, userInput, response);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineResponse(
                              response: response,
                              medicineName: userInput,
                            ),
                          ),
                        );
                        medicineController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Simply enter the name of a drug, and we\'ll provide you with detailed information on its function and how it works. Stay informed about the medications you\'re taking with our drug insight.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Inter',
                  color: itemsColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
