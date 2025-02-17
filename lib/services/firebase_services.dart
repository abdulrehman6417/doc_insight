import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //function to store the user symptom history to database
  Future<void> storeSymptomCheckHistory(
      String userId, List symptoms, String response) async {
    try {
      await _firestore
          .collection('Symptom History')
          .doc(userId)
          .collection('checks')
          .add({
        'symptoms': symptoms,
        'response': response,
        'timestamp': Timestamp.now().toDate(),
      });
    } catch (e) {
      print('Error storing symptom check history: $e');
    }
  }

  //function to fetch the user symptom history from database
  Stream<List<Map<String, dynamic>>> getSymptomCheckHistory(String userId) {
    try {
      // Create a stream that listens for changes in the Firestore collection
      return FirebaseFirestore.instance
          .collection('Symptom History')
          .doc(userId)
          .collection('checks')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error retrieving symptom check history: $e');
      return Stream.value([]); // Return an empty stream on error
    }
  }
  // Future<List<Map<String, dynamic>>> getSymptomCheckHistory(
  //     String userId) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection('Symptom History')
  //         .doc(userId)
  //         .collection('checks')
  //         .get();
  //     return snapshot.docs.map((doc) => doc.data()).toList();
  //   } catch (e) {
  //     print('Error retrieving symptom check history: $e');
  //     return [];
  //   }
  // }

  /*--------------------------------------------------*/

  //function to store the user drugs/medicine history to database
  Future<void> storeMedicineInfoHistory(
      String userId, String medicineName, String response) async {
    try {
      await _firestore
          .collection('Medicine History')
          .doc(userId)
          .collection('info')
          .add({
        'medicine_name': medicineName,
        'response': response,
        'timestamp': Timestamp.now().toDate(),
      });
    } catch (e) {
      print('Error storing medicine info history: $e');
    }
  }

  //function to fetch the user drugs/medicine history from database
  Stream<List<Map<String, dynamic>>> getMedicineInfoHistory(String userId) {
    try {
      // Create a stream that listens for changes in the Firestore collection
      return FirebaseFirestore.instance
          .collection('Medicine History')
          .doc(userId)
          .collection('info')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      print('Error retrieving medicine info history: $e');
      return Stream.value([]); // Return an empty stream on error
    }
  }
}
