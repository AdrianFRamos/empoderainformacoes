import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/firebase_options.dart';
import 'package:empoderainformacoes/repository/authRepository.dart';
import 'package:empoderainformacoes/screens/forgetPassword.dart';
import 'package:empoderainformacoes/screens/homeScreen.dart';
import 'package:empoderainformacoes/screens/introScreen.dart';
import 'package:empoderainformacoes/screens/loginScreen.dart';
import 'package:empoderainformacoes/screens/otpScreen.dart';
import 'package:empoderainformacoes/screens/profileScreen.dart';
import 'package:empoderainformacoes/screens/signUpScreen.dart';
import 'package:empoderainformacoes/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/infoScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
    .then((value) => Get.put(AuthRepository())
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: const CircularProgressIndicator(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
        OTPScreen.routeName: (context) => const OTPScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        InfoScreen.routeName: (context) => const InfoScreen(),
      },
    );
  }
}