import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackground extends StatelessWidget {
  final Widget otherWidget;
  final bool maximizeHeight;
  const CustomBackground(
      {super.key, required this.otherWidget, this.maximizeHeight = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Container(
              height: maximizeHeight ? Get.height : 320,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: maximizeHeight
                      ? const [
                          Color(0xffD6E3D0),
                          Color(0xffBCD7EC),
                          Color(0xff9794FE),
                        ]
                      : const [
                          Color(0xff97469E),
                          Color(0xff1B0325),
                        ],
                ),
              ),
            ),
          ],
        ),
        otherWidget,
      ],
    );
  }
}
