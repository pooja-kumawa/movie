import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
        crossAxisAlignment: CrossAxisAlignment.center,  // Center the content horizontally
        children: [
          // The splash image centered in the screen
          Center(
            child: Image.asset(
              'assets/splash_image.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.8,  // Adjust image width according to screen width
              height: MediaQuery.of(context).size.height * 0.5,  // Adjust image height according to screen height
            ),
          ),
          SizedBox(height: 20),  // Add some space between the image and text
          // The text centered below the image
          Center(
            child: Text(
              'Welcome to MovieApp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
