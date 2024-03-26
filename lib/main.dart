import 'package:classconnect/locator.dart';
import 'package:classconnect/services/auth.dart';
import 'package:classconnect/views/home_page.dart';
import 'package:classconnect/views/landing_page.dart';
import 'package:classconnect/views/sign_in/cubit/sign_in_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthService authService = locator<AuthService>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
            create: (context) => SignInCubit(authService)),
      ],
      child: MaterialApp(
        title: 'Class Connect',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        debugShowCheckedModeBanner: false,
        home: authService.isLoggedIn() ? const HomePage() : const LandingPage(),
      ),
    );
  }
}
