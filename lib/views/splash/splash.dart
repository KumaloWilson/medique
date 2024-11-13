import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/utils/routes.dart';
import '../../core/constants/local_image_constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      if (mounted && context.mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.repeat();
    });


    // Navigate to AuthHandler after initialization
    _navigateToAuthHandler();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _navigateToAuthHandler() async{
    await Future.delayed(const Duration(seconds: 5));

    Get.offAllNamed(RoutesHelper.initialScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            Positioned(
              bottom: -300,
              top: -300,
              left: -300,
              right: -300,
              child: RotationTransition(
                turns: _animation,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      LocalImageConstants.splashBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              left: 20,
              right: 20,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top + 60,
                  ),
                  const Text.rich(
                    TextSpan(
                      text: "MediGuide",
                      style: TextStyle(
                          fontSize: 30
                      ),
                      children: [
                        TextSpan(
                          text: '.AI',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Welcome,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Health Delivery Made Simple",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: MediaQuery.paddingOf(context).bottom + 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
