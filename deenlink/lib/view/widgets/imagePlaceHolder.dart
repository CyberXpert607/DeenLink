import 'package:flutter/material.dart';

class Imageplaceholder extends StatelessWidget{
  final String assetPath;
  const Imageplaceholder({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
    );
}
}