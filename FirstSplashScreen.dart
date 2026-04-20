import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_the_way/constans/Color.dart';
import 'package:on_the_way/view/page/HomePage.dart';
import 'package:on_the_way/view/page/LoginPage.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
            splashTransition: SplashTransition.slideTransition,
            splashIconSize: 300,
            splash: Column(
              children: [
                 Text('ON THE WAY !',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: MyColors.primary),),
                 Lottie.asset('asset/s1.json')

              ],
            ),
            nextScreen: LoginPage(),
    duration: 4000, );
  }
}
