import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/loginController.dart';
import 'package:empoderainformacoes/screens/forgetPassword.dart';
import 'package:empoderainformacoes/screens/signUpScreen.dart';
import 'package:empoderainformacoes/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widgets/forgetPasswordWidget.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color:const Color.fromARGB(255, 245, 200, 229),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Image.asset(Helper.getAssetName("mulheraceno.png", "icons"),
                height: 200,
                ),
                const Text(
                  "Faça Seu Login",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: controller.email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "E-mail",
                            hintText: "E-nail",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller.password,
                          validator: (value) {
                            if (value!.isEmpty) return 'Digite sua senha';
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: "Senha",
                            hintText: "Senha",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: null, 
                              icon: Icon(Icons.remove_red_eye_sharp)
                            )
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: const Color.fromARGB(255, 245, 200, 229),
                                context: context, 
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                builder: (context) => Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Selecione uma das opções",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                     const Text(
                                        "Selecione uma das opções para fazer um reset da sua senha",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ForgetPasswordWidget(
                                        title: "E-mail",
                                        description: "Resete via verificação por e-mail",
                                        icon: Icons.email,
                                        onTap: (){
                                          Navigator.of(context).restorablePushReplacementNamed(ForgetPasswordScreen.routeName);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ForgetPasswordWidget(
                                        title: "Telefone",
                                        description: "Resete via verificação por telefone",
                                        icon: Icons.mobile_friendly,
                                        onTap: (){},
                                      ),
                                    ],
                                  ),
                                )
                              );
                            },
                            child: Text(
                              "Esqueceu sua senha ?",
                              style: Helper.getTheme(context).labelLarge,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => controller.login(),
                            child:  const Text(
                              "LOGIN",
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          child: Text(
                            "Ou",
                            style: Helper.getTheme(context).labelLarge,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Image(image: AssetImage("assets/logos/google.png"),width: 20,),
                            onPressed: (){}, 
                            label:  Text(
                              "Faça Login com o Google",
                              style: Helper.getTheme(context).labelLarge,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Voce ainda não tem uma conta ? ",
                                children: [
                                  TextSpan(
                                    text: "Cadastre-se",
                                    style: Helper.getTheme(context).labelLarge,
                                  )
                                ],
                                style: Helper.getTheme(context).labelLarge,
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
