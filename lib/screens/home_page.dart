import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFCC7CFC)],
            begin: Alignment.topLeft,
            stops: [
              1.2,
              0.0,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: const Column(
          children: <Widget>[
            Text(
              'Welcome to Home Page',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
