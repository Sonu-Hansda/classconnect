import 'dart:developer';

import 'package:classconnect/views/sign_in/sign_in.dart';
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
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fname.dispose();
    _lname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

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
              key: _formKey,
              child: Column(
                children: [
                  customTextForm(
                      controller: _fname,
                      hintText: 'First Name',
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Required';
                        } else if (val.length <= 1) {
                          return 'Too short';
                        }
                        return null;
                      },
                      preIcon: const Icon(Icons.person)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      controller: _lname,
                      hintText: 'Last Name',
                      preIcon: const Icon(Icons.person_2_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      controller: _email,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Required';
                        } else if (!val.contains('@')) {
                          return 'Invalid email';
                        } else if (!val.endsWith('nitjsr.ac.in')) {
                          return 'only collge email is allowed';
                        }
                        return null;
                      },
                      hintText: 'Email Address',
                      preIcon: const Icon(Icons.email_outlined)),
                  const SizedBox(height: 12.0),
                  customTextForm(
                      isPassword: !showPassword,
                      controller: _password,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Atleast 6 characters long.';
                        }
                        return null;
                      },
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
                      controller: _confirmPassword,
                      hintText: 'Confirm Password',
                      isPassword: true,
                      validate: (val) {
                        if (_password.text != _confirmPassword.text) {
                          return 'Password not match';
                        }
                        return null;
                      },
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
                  CustomButton(
                    text: 'Create now',
                    backgroundColor: const Color(0xFF7CFCAF),
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        log("Fine");
                      }
                    },
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
