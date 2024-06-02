import 'package:ai_therapy/View/home_view.dart';
import 'package:ai_therapy/constants.dart';
import 'package:ai_therapy/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../Controllers/user_controller.dart';

class ConverstaionModeScreen extends StatelessWidget {
  const ConverstaionModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: CustomBackground(
        otherWidget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset("assets/robot.png"),
                    Text(
                      "All Set!",
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "How are you feeling today?",
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    _mainButton(
                      context,
                      "Let's start the Conversation",
                      null,
                      Color(0xff7EF7E1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // _mainButton(
                    //     context, "Over Text Chat", Icons.chat, sliderGreen),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _mainButton(
      BuildContext context, String text, IconData? icon, Color color) {
    if (icon == null) {
      Get.find<UserController>().selectedConvMode.value = 1;
    } else {
      Get.find<UserController>().selectedConvMode.value = 0;
    }
    return GestureDetector(
      onTap: () {
        Vibrate.feedback(FeedbackType.heavy);
        Get.to(
          () => const HomeView(),
          curve: Curves.easeIn,
          transition: Transition.downToUp,
          // duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color.withOpacity(.2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null
                  ? Image.asset(
                      "assets/voice_chat.png",
                      width: 35,
                      height: 35,
                    )
                  : Icon(
                      icon,
                      size: 30,
                      color: sliderGreen,
                    ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: color,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
