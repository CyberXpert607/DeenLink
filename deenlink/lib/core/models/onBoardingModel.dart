import 'package:flutter/material.dart';
class OnboardingModel {
  final String title;
  final String description;
  final String? assetPath;           // Background image
  final List<String>? avatarPaths;   // ← Multiple avatars (list)
  final String? buttonText;
  final bool showSkipButton;
  final VoidCallback? onButtonTap;
  final Color? backgroundColor;      // ← Custom background color
  
  OnboardingModel({
    required this.title,
    required this.description,
    this.assetPath,
    this.avatarPaths,                // ← Now a list!
    this.buttonText,
    this.showSkipButton = true,
    this.onButtonTap,
    this.backgroundColor,
  });
}