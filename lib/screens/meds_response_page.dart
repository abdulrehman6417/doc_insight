import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class MedicineResponse extends StatefulWidget {
  final String response;
  final String medicineName;
  const MedicineResponse(
      {super.key, required this.response, required this.medicineName});

  @override
  State<MedicineResponse> createState() => _MedicineResponseState();
}

class _MedicineResponseState extends State<MedicineResponse> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> lines =
        widget.response.split('\n'); // Split the response into lines

    // Initialize variables for each heading's content
    String functions = '';
    String working = '';

    String currentHeading = ''; // Track the current heading

    for (String line in lines) {
      line = line.trim(); // Remove leading and trailing whitespace

      if (line.endsWith(':')) {
        // If the line ends with a colon, it's a heading
        currentHeading =
            line.replaceAll(':', ''); // Remove the colon from the heading
      } else if (currentHeading.isNotEmpty) {
        // If the current heading is not empty, add the line to the corresponding variable
        switch (currentHeading) {
          case 'Functionality':
            functions +=
                '$line\n'; // Append the line to the suggestions variable
            break;
          case 'Working':
            working += '$line\n'; // Append the line to the medication variable
            break;
          default:
            // Handle other headings if needed
            break;
        }
      }
    }

    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: const TopBar(pageTitle: 'Drugs Insight'),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 20, 159, 17),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.medicineName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'InterBold',
                      color: secondaryWhite,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Functionality',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'InterBold',
                  color: itemsColor,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              height: 300, // Set a limited height for the container
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
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
              child: ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: RawScrollbar(
                          thumbVisibility: true,
                          radius: const Radius.circular(10),
                          thumbColor: const Color(0xffD1D1D1),
                          controller: scrollController,
                          interactive: true,
                          mainAxisMargin: 10,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: Text(
                                functions,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19,
                                  color: itemsColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Working',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'InterBold',
                  color: itemsColor,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              height: 300, // Set a limited height for the container
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
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
              child: ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: RawScrollbar(
                          thumbVisibility: true,
                          radius: const Radius.circular(10),
                          thumbColor: const Color(0xffD1D1D1),
                          controller: scrollController,
                          interactive: true,
                          mainAxisMargin: 10,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: Text(
                                working,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 19,
                                  color: itemsColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
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
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'InterBold',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
