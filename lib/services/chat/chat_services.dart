import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  // Get instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Go through each individual user
        final user = doc.data();
        // Return the user data
        return user;
      }).toList();
    });
  }

  // Send message

  // Get messages
}
