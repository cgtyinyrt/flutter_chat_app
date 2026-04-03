import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/models/message.dart';

class ChatServices {
  // Get instance of firebase firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<void> sendMessage(String receiverId, message) async {
    // Get the current user id
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // Construct chat room id for the two users(sorted to ensure uniqueness)
    List<String> userIds = [currentUserId, receiverId];
    userIds.sort();
    String chatRoomId = userIds.join("_");

    // Add new message to the database
    await _firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // Construct chat room id for the two users
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatRoomId = userIds.join("_");
    // Return the stream of messages for the chat room
    return _firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
