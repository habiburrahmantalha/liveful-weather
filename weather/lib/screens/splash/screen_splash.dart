import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather/screens/home/presentation/screen_home.dart';// Replace with your home screen widget import

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() {
    // Delay for 2 seconds and then navigate to home screen
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenHome()), // Replace with your home screen widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Your splash screen UI goes here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/app_icon.png", height: 128,),
            const SizedBox(height: 20),
            const Text(
              'Quick Weather App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 16,),
            Container(
                margin: const EdgeInsets.only(left: 140, right: 140),
                width: 96,
                height: 4,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(3)),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
