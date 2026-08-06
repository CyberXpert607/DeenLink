import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7DFF6A), Color(0xFF1D7A26)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange, width: 6),
                      ),
                    ).animate().slide(
                      begin: Offset(-1, 0),
                      end: Offset(0, 0),
                      duration: 1.seconds,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                      radius: 130,
                    ).animate().slide(
                      begin: Offset(-1, 0),
                      end: Offset(0, 0),
                      duration: 1.seconds,
                    ),
                  ],
                ),
                SizedBox(height: 70),
                Text(
                      'Welcome to DeenLink',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 400.ms),

                SizedBox(height: 12),
                Text(
                      'Join our comuunity to access your profile',
                      style: TextStyle(fontSize: 18, color: Colors.white60),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.6, end: 0, duration: 600.ms),
                Text(
                      'and all other features.',
                      style: TextStyle(fontSize: 18, color: Colors.white60),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.9, end: 0, duration: 800.ms),
                SizedBox(height: 39),
                SizedBox(
                  width: double.infinity,
                  child:
                      ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () => {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.login,
                                  color: Colors.black,
                                  size: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Login to Your Account',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(delay: 400.ms)
                          .fadeIn()
                          .slide(begin: Offset(0, 0), end: Offset(0, -0.3)),
                ),
                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child:
                      OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white24,
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              side: const BorderSide(
                                color: Colors.white30,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add, size: 26),
                                SizedBox(width: 8),
                                Text(
                                  'Create New Account',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(delay: 400.ms)
                          .fadeIn()
                          .slide(begin: Offset(0, 0), end: Offset(0, -0.3)),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
