import 'package:flutter/material.dart';
import 'package:flutter_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String time;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Light vs Dark mode for correct bubble colors
    bool isDarkMode = Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: isCurrentUser
                  ? Colors.white
                  : isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
          ),

          // Time inside bubble
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: isCurrentUser ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
