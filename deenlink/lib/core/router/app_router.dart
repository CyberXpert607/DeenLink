import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../features/auth/view/pages/loginScreen.dart';
import '../features/auth/view/pages/SignUp.dart';
import '../features/home/homepage.dart';
import '../features/splashScreen/SplashScreen.dart';
import '../features/auth/view/pages/onBoarding.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',

    redirect: (context, state) async {
      final location = state.matchedLocation;

      if (location == '/splash') return null;
      final destination = await ref.read(appStartDestinationProvider.future);

      if (location == '/onboarding' && destination == AppDestination.onboarding)
        return null;
      if (location == '/login' && destination == AppDestination.login)
        return null;
      if (location == '/home' && destination == AppDestination.home)
        return null;

      switch (destination) {
        case AppDestination.onboarding:
          return '/onboarding';
        case AppDestination.login:
          return '/login';
        case AppDestination.home:
          return '/';
      }
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    ],
  );
});
