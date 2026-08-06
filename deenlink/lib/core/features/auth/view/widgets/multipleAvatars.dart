import 'package:flutter/material.dart';
import 'dart:ui';

class MultipleAvatars extends StatelessWidget{
  final List<String> avatarPaths;
  const MultipleAvatars({super.key, required this.avatarPaths});

  @override
  Widget build(BuildContext context) {
    return _buildMultipleAvatars(avatarPaths);
  }
}
     //for containers with animations...
  Widget _buildMultipleAvatars(List<String> avatarPaths) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: avatarPaths.map((path) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }