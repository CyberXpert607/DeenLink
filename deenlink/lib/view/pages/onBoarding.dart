import 'dart:ui';

import 'package:deenlink/core/models/onBoardingModel.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:deenlink/core/models/onBoardingModelInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _onBoardingScreen();
}

class _onBoardingScreen extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                onPageChanged: (index) => setState(() {
                  _currentPage = index;
                }),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return _buildSlide(slide);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(OnboardingModel slides) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (slides.assetPath != null)
          Image.asset(slides.assetPath!, fit: BoxFit.cover)
        // .animate(),
        else if (slides.backgroundColor != null)
          Container(color: slides.backgroundColor)
        else
          (Container(color: Colors.white)),

        if (slides.assetPath != null)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0A0A).withValues(alpha: 0.7),
                  Colors.transparent,
                  const Color(0xFF0A0A0A).withValues(alpha: 0.6),
                  const Color(0xFF0A0A0A).withValues(alpha: 0.7),
                ],
                stops: const [0.0, 0.25, 0.65, 0.95],
              ),
            ),
          ),

        Container(
          color: Colors.transparent,

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                            slides.title,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 0.9,
                              letterSpacing: -1,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(begin: -0.15, end: 0.0),
                      Text(
                            " DeenLink",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              height: 0.9,
                              letterSpacing: -1,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(begin: -0.15, end: 0.0),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(
                    slides.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      //height: 3.0,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
