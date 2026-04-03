import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/chat_bubble.dart';
import 'package:flutter_chat_app/services/auth/auth_service.dart';
import 'package:flutter_chat_app/services/chat/chat_services.dart';
import 'package:flutter_chat_app/components/my_textfield.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  // Text Controller for the message input field
  final TextEditingController _messageController = TextEditingController();

  // Chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // Send message function
  void _sendMessage() async {
    // If there is a message inside the text field
    if (_messageController.text.isNotEmpty) {
      // Send the message using chat services
      await _chatServices.sendMessage(receiverId, _messageController.text);
      // Clear the text field after sending
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(child: _buildMessagesList()),
          // User input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Return listView
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Is current user the sender of the message?
    bool isCurrentUser = data["senderId"] == _authService.getCurrentUser()!.uid;

    // Align message to the right if current user is the sender, otherwise align to the left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  // User input widget
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // Text field for message input
          Expanded(
            child: MyTextfield(
              hintText: "Type your message here",
              obscureText: false,
              controller: _messageController,
            ),
          ),

          // Send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
