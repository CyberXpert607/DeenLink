import 'package:deenlink/core/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      final destination = await ref
          .watch(appStartDestinationProvider.future)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              return AppDestination.login;
            },
          );

      if (!mounted) return;

      switch (destination) {
        case AppDestination.onboarding:
          context.go('/onboarding');
          break;
        case AppDestination.login:
          context.go('/login');
          break;
        case AppDestination.home:
          context.go('/');
          break;
      }
    } catch (e) {
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(appStartDestinationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1F2B25),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.orange.shade400,
                        width: 3,
                      ) /*
                      boxShadow: [
                        BoxShadow(
                          //color: Colors.orange.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],*/,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/deenlink.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.privacy_tip_rounded,
                              size: 50,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms)
                  .scale(
                    duration: 2000.ms,
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.1, 1.1),
                    curve: Curves.easeInOut,
                  ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Powered by",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.pinkAccent,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 16,
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    "assets/images/pixel_studios.png",
                    height: 50,
                    width: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'Pixel Studios',
                        style: TextStyle(
                          color: Colors.orange.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
