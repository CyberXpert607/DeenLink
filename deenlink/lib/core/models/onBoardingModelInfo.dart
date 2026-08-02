import 'package:deenlink/core/models/onBoardingModel.dart';

List<OnboardingModel> slides = [
  OnboardingModel(
    title: "Welcome to",
    description:
        "An All - in - one Islamic Application designed to help muslims practice islam efficiently and easily. Equipped with tons of models and features",
    assetPath: "assets/images/welcomeTheme.png",
    buttonText: "Continue",
    showSkipButton: false,
  ),

  OnboardingModel(
    title: "Explore DeenLink's models",
    description:
        "DeenLink is equipped with lots of models to make it easier and accessible for muslims to get in touch with thier deen",
    assetPath: "welcomeTheme.png",
    showSkipButton: true,
  ),

  OnboardingModel(
    title: "Ask Question",
    description:
        "With DeenLink seeking Fatwa from trusted and verified scholars is easy",
    assetPath: "assets/images/ask_quesion.png",
    showSkipButton: true,
  ),

  OnboardingModel(
    title: "Watch Videos",
    description: "Similar to instagram reels watch islamic content",
    assetPath: "assets/images/deenlink-ai.png",
    showSkipButton: true,
  ),
];
