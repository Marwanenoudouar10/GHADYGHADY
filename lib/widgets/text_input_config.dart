import 'package:flutter/material.dart';

class TextInputConfig{
  final String labelText;
  final TextEditingController? controller;
  final IconData? icon;
  final bool isObsecure;
  final TextInputType keyboardType;
  const TextInputConfig(
    {
    this.controller, 
    required this.labelText,
    this.icon,
    this.isObsecure = false,
    this.keyboardType = TextInputType.text,
    }
    );
}