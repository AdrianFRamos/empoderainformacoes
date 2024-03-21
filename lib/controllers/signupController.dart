import 'package:empoderainformacoes/models/userModel.dart';
import 'package:empoderainformacoes/repository/authRepository.dart';
import 'package:empoderainformacoes/repository/userRepository.dart';
import 'package:empoderainformacoes/screens/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final celular = TextEditingController();

  void dispose() {
  email.dispose();
  password.dispose();
  fullname.dispose();
  celular.dispose();
  super.dispose();
}

  final userRepository = Get.put(UserRepository());

  void registerUser(String email, String password) {
    String? error = AuthRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  Future<void> createUser(User user) async{
    await userRepository.createUser(user);
    phoneAuthentication(user.celular);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String celular){
    AuthRepository.instance.phoneAuthentication(celular);
  }
}
