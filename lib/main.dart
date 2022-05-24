import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherasmaa/Viwes/Screens/Home_Screen.dart';
//flutter pub get
// flutter pub run flutter_launcher_icons:main
void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  late final controller =
  AnimationController(duration: const Duration(seconds: 1), vsync: this)
    ..repeat(reverse: true);

  late final Animation<double> animation =
  CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedSplashScreen(
            duration: 3000,
            backgroundColor: Colors.white,
            splashIconSize: 500,
            splash: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350,
                    child: Lottie.asset('lib/images/4792-weather-stormshowersday.json',
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FadeTransition(
                    opacity: animation,
                    child: Text(
                      "Weather App....",
                      style: TextStyle(fontSize: 28, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            nextScreen: HomeScreen())), );
  }
}
