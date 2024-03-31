import 'package:classconnect/views/home_page.dart';
import 'package:classconnect/views/sign_in/cubit/sign_in_cubit.dart';
import 'package:classconnect/views/sign_up/sign_up.dart';
import 'package:classconnect/widgets/custom_button.dart';
import 'package:classconnect/widgets/custom_snackbar.dart';
import 'package:classconnect/widgets/custom_text_fields.dart';
import 'package:classconnect/widgets/slide_left.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(content: state.message, type: MessageType.error));
        } else if (state is SignInSuccess) {
          Navigator.pushReplacement(
              context, SlideLeftRoute(page: const HomePage()));
        } else if (state is SignInNotVerified) {
          customDialog(context);
        } else if (state is SignInEmailSent) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
              content: 'A verification email has been sent, Please verify.'));
        } else if (state is SignInEmailSentFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar(content: state.message));
        }
      },
      child: Scaffold(
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
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        if (state is SignInLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          text: 'Login',
                          backgroundColor: const Color(0xFFCC7CFC),
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInCubit>().signIn(
                                  _email.text.trim(), _password.text.trim());
                            }
                          },
                        );
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
      ),
    );
  }

  Future<dynamic> customDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'send verification mail ?',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          alignment: Alignment.center,
          contentPadding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Your email address is not verified. Please verify your email to log in to your account.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                return CustomButton(
                  text:
                      state is SignInEmailSending ? 'sending ...' : 'Get mail',
                  backgroundColor: state is SignInEmailSending
                      ? Colors.purple.shade200
                      : Colors.purple,
                  ontap: () async => await context
                      .read<SignInCubit>()
                      .verifyEmail(_email.text, _password.text),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'No thanks',
              backgroundColor: Colors.white70,
              ontap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
