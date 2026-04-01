import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyUserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Icon(Icons.person),
              // User Name
              SizedBox(width: 25),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
