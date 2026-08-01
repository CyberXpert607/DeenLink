import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // 1. Controller to manage page jumps and track current state
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // 2. Data model structure for your welcome screens
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to AppName",
      "description": "Discover a new way to optimize your daily workflow effortlessly.",
      "image": "assets/images/welcomeTheme.png", // Replace with your local asset paths
    },
    {
      "title": "Stay Connected",
      "description": "Real-time sync ensures you never miss a critical update or message.",
      "image": "assets/images/welcomeTheme.png",
    },
    {
      "title": "Achieve Your Goals",
      "description": "Monitor progress analytics and hit your targets faster than ever.",
      "image": "assets/images/welcomeTheme.png",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button header block
            Alignment.topRight == Alignment.topRight
                ? Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () => _pageController.jumpToPage(_onboardingData.length - 1),
                      child: const Text("Skip", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  )
                : const SizedBox.shrink(),

            // 3. PageView Core implementation
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dynamic placeholder/image container
                        Image.asset(
                          _onboardingData[index]["image"]!,
                          height: 280,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          _onboardingData[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[index]["description"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 4. Dot indicator layout array
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  width: _currentIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.blue : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 5. Contextual Action button footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == _onboardingData.length - 1) {
                      // Final Destination routing (e.g., Auth/Home screen)
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    _currentIndex == _onboardingData.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
