import 'dart:math' as math;
import 'package:fleekhr/common/utils/src_link/appvectors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashscreenOne extends StatefulWidget {
  const SplashscreenOne({super.key});

  @override
  State<SplashscreenOne> createState() => _SplashscreenOneState();
}

class _SplashscreenOneState extends State<SplashscreenOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotateAnimationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _shiftAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    //Initialize the animation controller
    _rotateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    //rotation animation for the First image
    //Then same controller will be used for the second image
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: math.pi / 4, // 45 degrees in radians
    ).animate(CurvedAnimation(
      parent: _rotateAnimationController,
      curve: Interval(0, 0.5, curve: Curves.easeInOut),
    ));

    //Shift Animation for Image 1(move left, last 2 seconds)
    _shiftAnimation = Tween<double>(
      begin: 0,
      end: -10, // Move left by 100 pixels
    ).animate(CurvedAnimation(
      parent: _rotateAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    //Fade Animation for Image 2 (last 2 seconds)
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1, // Fade in from 0 to 1
    ).animate(CurvedAnimation(
      parent: _rotateAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.easeIn),
    ));

    // Slide animation for Image 2 (left to right, last 2 seconds)
    _slideAnimation = Tween<double>(
      begin: 0, // Start off-screen to the left
      end: -50, // End 100 pixels to the right of center
    ).animate(
      CurvedAnimation(
        parent: _rotateAnimationController,
        curve: const Interval(0.5, 1.0,
            curve: Curves.fastLinearToSlowEaseIn), // 2-4s
      ),
    );
    // Listen to the animation controller to navigate to the next page
    _rotateAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.go('/onboard'); // Navigate to the login page
        // Optionally, you can also dispose of the controller here if you don't need it anymore
      }
    });
    //Start the animation
    _rotateAnimationController.forward();
  }

  @override
  void dispose() {
    _rotateAnimationController.dispose();
    super.dispose();
  }

  // void NavigateToLoginPage() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           const LoginPage(), // Replace with your login page widget
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _rotateAnimationController,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animation 1: Image 1: Rotates then shifts left
                  Transform.translate(
                    offset: Offset(_shiftAnimation.value, 0),
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Image.asset(
                        Appvectors.animatedImg, // Replace with your image path
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  // Animation 2: Image 2: Fades in and slides from left to right
                  Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(_slideAnimation.value, 0),
                      child: Image.asset(
                        Appvectors
                            .animatedImg2, // Replace with your second image path
                        width: 180,
                        height: 180,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
