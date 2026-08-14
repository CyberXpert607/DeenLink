import 'dart:ui';

import 'package:deenlink/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  //! Implement the prototype of the login and create account screens

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final error = authState is AuthError ? authState.message : null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackGround(),
          //!Dark overlay dims the background!
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.15)),
          ),
          _buildScrollableContainer(context, screenHeight, error),
        ],
      ),
    );
  }

  Widget _buildBackGround() {
    return Positioned.fill(
      child: Image.asset(
        "assets/images/deenlink_background.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildScrollableContainer(
    BuildContext context,
    double screenHeight,
    String? error,
  ) {
    return Positioned(
      top: screenHeight * 0.30,
      right: 20,
      left: 20,
      bottom: 25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(48),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.67,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: Colors.white.withValues(alpha: .09),
              border: Border.all(color: Colors.black.withValues(alpha: 0.4)),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.red.withValues(alpha: 0.1),
                        child: Text(
                          error,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    _buildInputField(
                      context: context,
                      hintText: "enter your email",
                      icon: FontAwesomeIcons.envelope,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[w-.]+@([w-]+.)+[w-]{2,4}$',
                        ).hasMatch(value)) {
                          //! Find another better RegExp!
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    //SizedBox(height: 12),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildInputField(
                      context: context,
                      hintText: "enter your password",
                      icon: FontAwesomeIcons.lock,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: FaIcon(
                          obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 22,
                          color: Colors.orange.withValues(alpha: .5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: Duration(milliseconds: 500)),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required FaIconData icon,
    required TextEditingController controller,
    required TextInputType keyboardType,
    Widget? suffixIcon,
    bool obscureText = false,
    required BuildContext context,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: Colors.orange.withValues(alpha: .5),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, right: 8, top: 15),
          child: FaIcon(
            icon,
            size: 22,
            color: Colors.orange.withValues(alpha: .5),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
          minHeight: 50,
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 50,
          minWidth: 50,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.green.withValues(alpha: .5),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.red,
            width: 4,
            style: BorderStyle.solid,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
