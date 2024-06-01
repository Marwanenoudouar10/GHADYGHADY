import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String text;
  final String secondText;
  const TopBar({super.key, required this.text, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title:  Text(
              text,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            subtitle:  Text(
              secondText,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey, // Optionally, adjust the color to match your design
              ),
            ),
            isThreeLine: true, // Set to true if the subtitle may span more than one line
            contentPadding: EdgeInsets.zero, // Adjust padding if needed
          ),
        ],
      ),
    );
  }
}
