import 'package:ai_therapy/View/home_view.dart';
import 'package:ai_therapy/constants.dart';
import 'package:ai_therapy/onBoarding/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import math

void main() async {
  //Ensure flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  var firstTime = true;

  @override
  void initState() {
    if (box.read("firstTime") != null) {
      firstTime = box.read("firstTime");
    } else {
      box.write("firstTime", false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Nexa",
        canvasColor: Colors.transparent,

        sliderTheme: const SliderThemeData(
          trackHeight: 15,
          thumbShape: _RectSliderThumbShape(width: 8),
        ),

        chipTheme: ChipThemeData(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          disabledColor: Colors.grey,
          selectedColor: buttonColor,
          secondarySelectedColor: buttonColor,
          padding: const EdgeInsets.all(10),
          side: const BorderSide(
            color: textColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          labelStyle: const TextStyle(
            color: textColor,
            fontSize: 14,
          ),
          secondaryLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          brightness: Brightness.light,
        ),

        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          displayMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        useMaterial3: true,
      ),
      home: firstTime ? const OnBoarding() : const HomeView(),
    );
  }
}

class _RectSliderThumbShape extends SliderComponentShape {
  final double width;
  const _RectSliderThumbShape({required this.width});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, 0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.thumbColor != null);

    final rect = Rect.fromCenter(
      center: center,
      width: width,
      height: 45,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(width / 2)),
      Paint()..color = sliderTheme.thumbColor!,
    );
  }
}
