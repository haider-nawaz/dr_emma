import 'package:ai_therapy/Widgets/custom_button.dart';
import 'package:ai_therapy/onBoarding/select_user_issues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../custom_background.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        otherWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Text(
                    "Hey there! 👋",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "I'm Dr. Emma, your personal AI therapist.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              CustomButton(
                  text: "READY TO GET STARTED?",
                  onPressed: () {
                    Vibrate.feedback(FeedbackType.success);
                    Get.to(
                      () => const SelectUserIssues(),
                      curve: Curves.easeIn,
                      // transition: Transition.rightToLeftWithFade,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
