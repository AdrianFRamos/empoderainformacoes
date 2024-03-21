//import 'package:empoderainformacoes/repository/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/authRepository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login() async {
   String? error = await AuthRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }

  }
}