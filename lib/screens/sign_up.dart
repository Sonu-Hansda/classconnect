import 'package:classconnect/screens/sign_in.dart';
import 'package:classconnect/widgets/custom_button.dart';
import 'package:classconnect/widgets/custom_text_fields.dart';
import 'package:classconnect/widgets/slide_left.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fname = TextEditingController();

  final TextEditingController _lname = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ListView(
          children: [
            const Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 24.0),
            Form(
              child: Column(
                children: [
                  customTextForm(
                      controller: _fname,
                      hintText: 'First Name',
                      preIcon: const Icon(Icons.person)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      controller: _lname,
                      hintText: 'Last Name',
                      preIcon: const Icon(Icons.person_2_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      controller: _lname,
                      hintText: 'Email Address',
                      preIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      isPassword: !showPassword,
                      controller: _lname,
                      hintText: 'Password',
                      postIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(!showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined)),
                      preIcon: const Icon(Icons.password_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      controller: _lname,
                      hintText: 'Confirm Password',
                      preIcon: const Icon(Icons.password_outlined)),
                  const SizedBox(height: 12.0),
                  const Text.rich(
                    TextSpan(
                        text: 'By clicking on create now you agree to our ',
                        children: [
                          TextSpan(
                            text: 'tems & conditions.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const CustomButton(
                    text: 'Create now',
                    backgroundColor: Color(0xFF7CFCAF),
                    ontap: null,
                  ),
                  const SizedBox(height: 16.0),
                  Text.rich(
                    TextSpan(text: 'Already have an account? ', children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                              context, SlideLeftRoute(page: const SignIn())),
                        text: 'Sign in',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
