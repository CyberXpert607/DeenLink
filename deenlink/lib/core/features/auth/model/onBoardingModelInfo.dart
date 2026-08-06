import 'package:deenlink/core/features/auth/model/onBoardingModel.dart';

List<OnboardingModel> slides = [
  OnboardingModel(
    title: "Welcome to",
    assetPath: "assets/images/welcomeTheme.png",
    buttonText: "Continue",
    showSkipButton: false,
  ),

  OnboardingModel(
    title: "Explore DeenLink's models",
    description:
        "DeenLink is equipped with lots of models to make it easier and accessible for muslims to get in touch with thier deen",
    assetPath: "assets/images/welcomeTheme.png",
    showSkipButton: true,
    buttonText: "Explore"
  ),

  OnboardingModel(
    title: "DeenLink AI",
    description:
        "With DeenLink's AI seeking Fatwa from trusted and verified scholars is easy and other useful information backed with thousands of Trusted sources.",
    assetPath: "assets/images/deenlink-ai.png",
    showSkipButton: true,
  ),

  OnboardingModel(
    title: "Watch Videos",
    description: "Similar to instagram reels watch islamic content",
    assetPath: "assets/images/image24.jpg",
    showSkipButton: true,
  ),
];
