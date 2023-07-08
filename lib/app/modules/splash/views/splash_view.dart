import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/contants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);
  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/mail.json', height: 200, width: 200),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 20.0,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Welcome to MailBox',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {},
            ),
          ),
        ],
      )),
    );
  }
}
