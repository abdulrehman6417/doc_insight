import 'dart:convert';

import 'package:doc_insight/screens/health_response_page.dart';
import 'package:doc_insight/services/firebase_services.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:doc_insight/widgets/top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  //getting the current user id to store data
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //creating reference to class Firebase Services
  final firestoreService = FirestoreServices();

  List<Widget> symptomFields = [];
  List<TextEditingController> symptomControllers = [];
  List<String> symptoms = [];

  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  //open ai api key
  // ignore: non_constant_identifier_names
  String API_KEY = dotenv.env['PAGE_API_KEY'].toString();
  bool isLoading = false;

  //function to generate the dynamic prompt
  String generatePrompt() {
    String dynamicSymptoms = "";
    for (int i = 0; i < symptoms.length; i++) {
      dynamicSymptoms += symptoms[i];
      if (i < symptoms.length - 1) {
        dynamicSymptoms += " and ";
      }
    }
    return dynamicSymptoms;
  }

  //function to send the prompt and get the response from open ai
  Future<String> fetchResponse(
      String dynamicSymptoms, String gender, String age, String region) async {
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
            '{"prompt": "i\'m $age year old $gender from $region who\'s suffering from $dynamicSymptoms, what i want you to do is 1. provide me some suggestions under the heading \'suggestions\' 2. Provide me possible names of the pharmaceuticals that can help with it  under the heading \'medication\' 3. Provide me possible solutions under the heading \'solutions\' and try giving the name of medicines and make the terminologies much more simpler and easier to understand for layman. make it much more brief and short , cut down the crap and be much more specific.", "max_tokens": 500}',
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
  void initState() {
    super.initState();
    // Add initially 1 symptom text field
    addSymptomField();
  }

  void addSymptomField() {
    TextEditingController controller = TextEditingController();
    setState(() {
      symptomControllers.add(controller);
      symptomFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
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
                    controller: controller,
                    decoration: InputDecoration(
                      label: const Text('Add Symptoms'),
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
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: IconButton(
                          icon: const ImageIcon(
                            AssetImage('assets/images/delete.png'),
                            color: Colors.red,
                            size: 20,
                          ),
                          onPressed: () => removeSymptomField(controller),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void removeSymptomField(TextEditingController controller) {
    setState(() {
      int index = symptomControllers.indexOf(controller);
      symptomControllers.removeAt(index);
      symptomFields.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var controller in symptomControllers) {
      controller.dispose();
    }
    genderController.dispose();
    ageController.dispose();
    regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: const TopBar(pageTitle: 'Symptomology Insight'),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter symptoms for accurate results, starting\nwith your most severe one.',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Inter',
                        color: itemsColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ...symptomFields,
                    const SizedBox(height: 2.0),
                    GestureDetector(
                      onTap: addSymptomField,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/plus.png',
                              width: 22,
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              'Add more symptoms',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff4CAF50),
                                // fontFamily: 'InterBold',
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        controller: genderController,
                        decoration: InputDecoration(
                          label: const Text('-Gender-'),
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
                        controller: ageController,
                        decoration: InputDecoration(
                          label: const Text('-Age-'),
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
                        controller: regionController,
                        decoration: InputDecoration(
                          label: const Text('-Region-'),
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
                      title: 'Submit Symptoms',
                      onTap: () async {
                        setState(() {
                          symptoms.clear();
                          for (var i = 0; i < symptomFields.length; i++) {
                            symptoms.add(symptomControllers[i].text);
                          }
                        });
                        String gender = genderController.text;
                        String region = regionController.text;
                        String age = ageController.text;
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
                        String dynamicSymptoms = generatePrompt();
                        String response = await fetchResponse(
                            dynamicSymptoms, gender, age, region);
                        firestoreService.storeSymptomCheckHistory(
                            currentUserId, symptoms, response);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HealthResponse(
                              response: response,
                              symptoms: symptoms,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Our symtomology insight suggests potential medical\nconditions by comparing your symptoms with our\ndatabase. ',
              style: TextStyle(
                fontSize: 16.5,
                fontFamily: 'Inter',
                color: itemsColor,
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Powered by ',
                    style: TextStyle(
                      color: itemsColor,
                      fontFamily: 'InterBold',
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: 'HealthCare,inc.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
