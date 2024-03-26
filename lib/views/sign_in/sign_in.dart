import 'dart:developer';

import 'package:classconnect/views/sign_up/sign_up.dart';
import 'package:classconnect/widgets/custom_button.dart';
import 'package:classconnect/widgets/custom_text_fields.dart';
import 'package:classconnect/widgets/slide_left.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        alignment: Alignment.center,
        child: ListView(
          children: [
            const Text(
              'Welcome back !',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const Text(
              'Please login to continue',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 24.0),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextForm(
                      controller: _email,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'required';
                        } else if (!val.contains('@')) {
                          return 'invalid email';
                        } else if (!val.endsWith('nitjsr.ac.in')) {
                          return 'only college email is allowed';
                        }
                        return null;
                      },
                      hintText: 'Email Address',
                      preIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      isPassword: !showPassword,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      controller: _password,
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
                  CustomButton(
                    text: 'Login',
                    backgroundColor: const Color(0xFFCC7CFC),
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        log('working fine');
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text.rich(
                    TextSpan(text: 'Don\'t have an account? ', children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                              context, SlideLeftRoute(page: const SignUp())),
                        text: 'Create new',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
