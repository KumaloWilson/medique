import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/constants/color_constants.dart';
import 'package:medique/core/constants/local_image_constants.dart';

import '../../../core/utils/routes.dart';
import '../../../core/utils/shared_pref.dart';


class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final List<SingleIntroScreen> pages = [
    SingleIntroScreen(
      sideDotsBgColor: Pallete.primaryColor,
      title: 'MediGuide AI',
      description: 'Nurse Assistant System',
      imageAsset: LocalImageConstants.logo,
      imageHeightMultiple: 10.0,
    ),

    const SingleIntroScreen(
      sideDotsBgColor: Pallete.primaryColor,
      title: 'Manage Patients',
      description: 'Add New Patient and manage their files',
      imageAsset: LocalImageConstants.addPatients,
      imageHeightMultiple: 10.0,
    ),

    SingleIntroScreen(
      sideDotsBgColor: Pallete.primaryColor,
      title: 'Ask MediGuide',
      description: 'Prompt the AI system for diagnosis and treatments',
      imageAsset: LocalImageConstants.chatBot,
      imageHeightMultiple: 10.0,
    ),


    SingleIntroScreen(
      title: 'Are you Ready ?',
      sideDotsBgColor: Pallete.primaryColor,
      description: 'All you want ',
      imageAsset: LocalImageConstants.aiHub,
      imageHeightMultiple: 10.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedIntroduction(
        footerBgColor: Pallete.primaryColor,
        isFullScreen: true,
        slides: pages,
        indicatorType: IndicatorType.circle,
        onDone: () async {
          await CacheUtils.updateOnboardingStatus(true).then((value) {
            Get.offAllNamed(RoutesHelper.loginScreen);
          });
        });
  }
}
