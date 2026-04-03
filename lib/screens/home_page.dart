import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/my_drawer.dart';
import 'package:flutter_chat_app/components/my_usertile.dart';
import 'package:flutter_chat_app/screens/chat_page.dart';
import 'package:flutter_chat_app/services/chat/chat_services.dart';
import 'package:flutter_chat_app/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _authServices = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Colors.grey[700],
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading users"));
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Return list of users
        if (!snapshot.hasData) {
          return const Center(child: Text("No users found"));
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // Display all users except the current logged in user
    final currentUser = _authServices.getCurrentUser();

    if (userData["email"] != currentUser!.email) {
      return MyUserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
