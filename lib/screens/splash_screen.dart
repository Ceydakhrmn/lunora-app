import 'package:flutter/material.dart';

class DonguSplash extends StatelessWidget {
  const DonguSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/splash_bg.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
