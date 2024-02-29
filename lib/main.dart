import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/forgetPassword.dart';
import 'package:empoderainformacoes/screens/homeScreen.dart';
import 'package:empoderainformacoes/screens/introScreen.dart';
import 'package:empoderainformacoes/screens/loginScreen.dart';
import 'package:empoderainformacoes/screens/otpScreen.dart';
import 'package:empoderainformacoes/screens/signUpScreen.dart';
import 'package:empoderainformacoes/screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empodera Informações',
      theme: ThemeData(
        fontFamily: "Montserrat-itallic",
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
             AppColor.orange,
            ),
            shape: MaterialStateProperty.all(
              const StadiumBorder(),
            ),
            elevation: MaterialStateProperty.all(0)
          )
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColor.primary,
            fontSize: 20
          ),
          bodyMedium: TextStyle(
            color: AppColor.secondary
          )
        )
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
        OTPScreen.routeName: (context) => const OTPScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}