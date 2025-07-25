import 'package:flutter/material.dart';
import 'package:medique/core/constants/local_image_constants.dart';
import '../../../../animations/leftbounce_animation.dart';
import '../../../../animations/rightbounce_animation.dart';
import '../../../../core/constants/color_constants.dart';

class AIHub extends StatefulWidget {
  const AIHub({super.key});

  @override
  State<AIHub> createState() => _AIHubState();
}

class _AIHubState extends State<AIHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        title: const Text(
            'AI Hub'
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 270,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: BounceFromLeftAnimation(
                    delay: 1.5,
                    child: GestureDetector(
                      onTap: () {
                        //Helpers.temporaryNavigator(context, const AskMediGuideScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Pallete.primaryColor)),
                        child: Column(
                          children: [
                            Image.asset(
                              LocalImageConstants.chatBot,
                              height: 120,
                            ),
                            Text(
                              'Medical\nChatbot',
                              style: TextStyle(
                                color: Pallete.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: BounceFromRightAnimation(
                    delay: 1.5,
                    child: GestureDetector(
                      onTap: () {
                        //Helpers.temporaryNavigator(context, const XrayScanner());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Pallete.primaryColor)),
                        child: Column(
                          children: [
                            Image.asset(
                              LocalImageConstants.xRayScanner,
                              height: 120,
                            ),
                            Text(
                              'TB Xray\nScanner',
                              style: TextStyle(
                                color: Pallete.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: BounceFromRightAnimation(
                    delay: 2,
                    child: GestureDetector(
                      onTap: (){
                        //Helpers.temporaryNavigator(context, const SymptomChecker());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Pallete.primaryColor)),
                        child: Column(
                          children: [
                            Image.asset(
                              LocalImageConstants.symptomChecker,
                              height: 100,
                            ),
                            Text(
                              'Symptom\nChecker',
                              style: TextStyle(
                                color: Pallete.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: BounceFromLeftAnimation(
                    delay: 2,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.chatBot,
                            height: 120,
                          ),
                          Text(
                            'Patient Charts',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
