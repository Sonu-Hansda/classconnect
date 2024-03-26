import 'package:classconnect/views/sign_in/sign_in.dart';
import 'package:classconnect/views/sign_up/sign_up.dart';
import 'package:classconnect/widgets/custom_button.dart';
import 'package:classconnect/widgets/slide_left.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
        child: Column(
          children: <Widget>[
            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const Text.rich(
              TextSpan(text: 'Class ', children: [
                TextSpan(
                    text: 'Connect', style: TextStyle(color: Color(0xFFA006FF)))
              ]),
              style: TextStyle(
                fontSize: 42.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 24.0),
            Image.asset('assets/image.png'),
            const SizedBox(height: 24.0),
            CustomButton(
              ontap: () => Navigator.push(
                context,
                SlideLeftRoute(page: const SignIn()),
              ),
              text: 'Login',
              backgroundColor: const Color(0xFF7CFCAF),
              textColor: Colors.black,
            ),
            const SizedBox(height: 14.0),
            CustomButton(
              ontap: () =>
                  Navigator.push(context, SlideLeftRoute(page: const SignUp())),
              text: 'Create Account',
              backgroundColor: const Color(0xFFCC7CFC),
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
