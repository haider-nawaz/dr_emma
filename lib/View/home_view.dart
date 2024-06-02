import 'package:ai_therapy/Controllers/chat_controller.dart';
import 'package:ai_therapy/Controllers/user_controller.dart';
import 'package:ai_therapy/constants.dart';
import 'package:ai_therapy/custom_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../onBoarding/customize_attributes_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late ChatController chatController;
  late AnimationController _animController;
  late UserController userController;

  @override
  void initState() {
    userController = Get.put(UserController());

    chatController = Get.put(ChatController());
    _animController = AnimationController(
      vsync: this,
    );
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   chatController.startListening();
    // });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  //post frame callback to start the animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        otherWidget: Obx(
          () => chatController.loading.value
              ? const Center(child: Text("Getting ready.."))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/robot.png",
                              height: 120,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(
                                  () => const CustomizeAttributesScreen(
                                    saveDetails: true,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              icon: const Icon(Icons.settings),
                              color: sliderGreen,
                              iconSize: 35,
                            ),
                          ],
                        ),
                        Obx(() => chatController.isListening.value
                            ? chatController.isListeningDone.value
                                ? Animate(
                                    child: Lottie.asset(
                                    'assets/speaking.json',
                                    height: 200,
                                    controller: _animController,
                                    onLoaded: (composition) {
                                      // Configure the AnimationController with the duration of the
                                      // Lottie file and start the animation.
                                      _animController.duration =
                                          composition.duration;

                                      _animController.repeat();
                                    },
                                  )).fadeIn()
                                : Animate(
                                    child: Lottie.asset(
                                      'assets/listening.json',
                                      height: 200,
                                      controller: _animController,
                                      onLoaded: (composition) {
                                        // Configure the AnimationController with the duration of the
                                        // Lottie file and start the animation.
                                        _animController.duration =
                                            composition.duration;
                                        _animController.forward();
                                      },
                                    ),
                                  ).fadeIn()
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    chatController.startListening();
                                  },
                                  icon: const Icon(
                                    Icons.mic,
                                    size: 70,
                                    color: sliderGreen,
                                  ),
                                ),
                              ).animate().fadeIn()),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //a cancel icon button with red background

            if (chatController.isListeningDone.value)
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () {
                    chatController.stopListening();
                  },
                  icon: const Icon(CupertinoIcons.pause),
                  color: Colors.white,
                  iconSize: 35,
                ),
              ),
            chatController.isListeningDone.value
                ? const SizedBox()
                : Text(
                    chatController.isListening.value
                        ? "Listening.."
                        : "Start Speaking by pressing\nthe above button",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),

            if (chatController.isListeningDone.value)
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () {
                    chatController.stopListening();
                  },
                  icon: const Icon(CupertinoIcons.xmark),
                  color: Colors.white,
                  iconSize: 35,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
