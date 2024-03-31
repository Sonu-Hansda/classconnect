import 'package:classconnect/locator.dart';
import 'package:classconnect/services/auth.dart';
import 'package:classconnect/utilities/response.dart';
import 'package:classconnect/views/landing_page.dart';
import 'package:classconnect/widgets/custom_button.dart';
import 'package:classconnect/widgets/slide_left.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              const Text(
                'Welcome to Home Page',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomButton(
                ontap: () async {
                  Response response = await locator<AuthService>().signOut();
                  if (response.status == ResponseType.success) {
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                        context,
                        SlideLeftRoute(page: const LandingPage()),
                        (route) => false);
                  }
                },
                text: 'Log out',
                backgroundColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
