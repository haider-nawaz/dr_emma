import 'package:ai_therapy/Widgets/custom_button.dart';
import 'package:ai_therapy/Widgets/custom_slider.dart';
import 'package:ai_therapy/custom_background.dart';
import 'package:ai_therapy/onBoarding/conversation_mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/user_controller.dart';

class CustomizeAttributesScreen extends StatelessWidget {
  final bool saveDetails;
  const CustomizeAttributesScreen({super.key, required this.saveDetails});

  @override
  Widget build(BuildContext context) {
    final userController =
        Get.find<UserController>() ?? Get.put(UserController());
    return Scaffold(
      // appBar: AppBar(),
      body: CustomBackground(
        otherWidget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "I'm going to help you through your mental health journey.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      saveDetails
                          ? "Customize me to your liking!"
                          : "What attributes would you like\nme to have?",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Obx(
                      () => CustomSlider(
                        leadingText: "Empathy",
                        trailingText: "Understanding",
                        defaultValue: userController.empUnd.value.toDouble(),
                        onChanged: (value) {
                          userController.empUnd.value = value.round();
                        },
                      ),
                    ),
                    Obx(
                      () => CustomSlider(
                        leadingText: "Listening",
                        trailingText: "Solutioning",
                        defaultValue: userController.lisSol.value.toDouble(),
                        onChanged: (value) {
                          userController.lisSol.value = value.round();
                        },
                      ),
                    ),
                    Obx(
                      () => CustomSlider(
                        leadingText: "Holistic",
                        trailingText: "Targeted",
                        defaultValue: userController.hoTa.value.toDouble(),
                        onChanged: (value) {
                          userController.hoTa.value = value.round();
                        },
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                CustomButton(
                    text: saveDetails ? "Save" : "Continue",
                    onPressed: () {
                      if (saveDetails) {
                        Get.back();
                      } else {
                        Get.to(() => const ConverstaionModeScreen());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
