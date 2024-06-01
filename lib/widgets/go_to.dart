import 'package:flutter/material.dart';

class GoTo extends StatelessWidget {
  final String text;
  final String secondText;
  final String linkTo;

  const GoTo({
    super.key,
    required this.text,
    required this.secondText,
    required this.linkTo,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, linkTo),
            child: Text(
              secondText,
              style: const TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
                color: Color(0xFFFF5700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
