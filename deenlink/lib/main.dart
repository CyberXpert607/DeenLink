import 'package:deenlink/view/pages/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ios_preview/flutter_ios_preview.dart';

void main() {
  runApp(
    const IosPreview(
      deviceModel: DeviceModel.iPhone16ProMax,
      enableInspector: false,
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), //dark
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
