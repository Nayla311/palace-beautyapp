import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3F4),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Image - Replace with your actual image path
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/logo.png', // Add your logo image here
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to the original icon if image fails to load
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.pink.shade200,
                                    Colors.pink.shade400,
                                    Colors.pink.shade600,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.face_retouching_natural,
                                size: 100,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // App Title
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.pink.shade400,
                          Colors.pink.shade600,
                          Colors.purple.shade400,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'Beauty Palace',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Where Beauty Meets Perfection',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink.shade500,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Creator Info
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Created by',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Nayoy🌸',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Loading
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: const Color.fromARGB(255, 127, 177, 224),
                        rightDotColor: const Color(0xFFEA3799),
                        size: 50,
                      ),
                    ),
                    Text(
                      'Preparing your beauty experience...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.pink.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
