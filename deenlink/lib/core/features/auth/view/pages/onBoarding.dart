import 'dart:ui';
import 'package:deenlink/core/features/auth/model/onBoardingModel.dart';
import 'package:deenlink/core/services/onboarding_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:deenlink/core/features/auth/model/onBoardingModelInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _onBoardingScreen();
}

class _onBoardingScreen extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  Future<void> _launch(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Could not launch ${url.toString()}"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
  /*
  Future<void> _finishOnboarding() async {
    await OnboardingService.markSeen();

    if(mounted) context.go('/login');
  } 
  let's seee whether the _goToNext() function can do the same job*/

  void _goToNext() async {
    if (_currentPage < slides.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      await OnboardingService.markSeen();
      if (mounted) context.go('/login');
    }
  }

  void _skipToEnd() {
    setState(() {
      _currentPage = slides.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
          bottom: false,
          top: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: slides.asMap().entries.map((entry) {
                    final index = entry.key;
                    final slide = entry.value;
                    return _buildSlide(slide, index);
                  }).toList(),
                ),
              ),
              //skip button
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 20,
                child: slides[_currentPage].showSkipButton
                    ? TextButton(
                        onPressed: _skipToEnd,
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withValues(alpha: .8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              //elevated button at the bottom
              Positioned(
                bottom:
                    MediaQuery.of(context).padding.bottom +
                    45, //take a look into this
                left: 60,
                right: 60,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      // height: 55,
                      child: ElevatedButton(
                        onPressed: _goToNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4, //shadow emphasis
                        ),
                        child: Text(
                          slides[_currentPage].buttonText ??
                              (_currentPage == slides.length - 1
                                  ? "Get Started"
                                  : "Continue"),
                          style: GoogleFonts.agbalumo(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),

                    //Privacy and Policy text under
                    if (_currentPage == 0)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 10,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'By clicking "Continue" or swiping forward, you agree to our ',
                              ),
                              TextSpan(
                                text: "Terms & Conditions",
                                style: TextStyle(
                                  color: Colors.green.shade900,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launch(
                                      Uri.parse(
                                        'https://deenlink.org/terms.html',
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(text: " and "),

                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.green.shade900,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    _launch(
                                      Uri.parse(
                                        "https://deenlink.org/privacy.html",
                                      ),
                                    );
                                  },
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (_currentPage > 0)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 20,
                  left: 20,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        if (_controller.page != null && _controller.page! > 0) {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      splashRadius: 20,
                    ),
                  ),
                ),
              //page indicator containers.
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 17,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: _currentPage == index ? 7 : 7,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.green
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(OnboardingModel slides, int pageIndex) {
    //image under and overlay cover
    final isFirstPage = pageIndex == 0;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (slides.assetPath != null)
          Image.asset(slides.assetPath!, fit: BoxFit.cover)
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
                  const Color(0xFF0A0A0A).withValues(alpha: 0.6),
                  Colors.transparent,
                  const Color(0xFF0A0A0A).withValues(alpha: 0.5),
                  const Color(0xFF0A0A0A).withValues(alpha: 0.4),
                ],
                stops: const [0.0, 0.25, 0.65, 0.95],
              ),
            ),
          ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          slides.title,
                          key: ValueKey(slides.title),
                          style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.1,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                      .slideY(begin: -0.2, end: 0, duration: 700.ms),

                  if (isFirstPage) ...[
                    const SizedBox(height: 8),
                    // "DeenLink" in green
                    AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            "DeenLink",
                            key: ValueKey("DeenLink$_currentPage"),
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                        .slideY(begin: -0.2, end: 0, duration: 700.ms),
                  ],

                  const SizedBox(height: 24),

                  AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Container(
                          key: ValueKey(slides.description),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            slides.description ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms, curve: Curves.easeOut)
                      .slideY(begin: 0.1, end: 0, duration: 800.ms),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black.withValues(alpha: 0.2),
              ],
              stops: const [0.0, 0.1, 0.9, 0.95, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
