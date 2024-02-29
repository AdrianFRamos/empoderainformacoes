import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/loginScreen.dart';
import 'package:empoderainformacoes/utils/helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/SignUpScreen";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color:const Color.fromARGB(255, 245, 200, 229),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Image(image: AssetImage(Helper.getAssetName("mulheraceno.png", "icons")),
                height: 150,
                ),
                const SizedBox(
                          height: 15,
                        ),
                Text(
                  "Faça Seu Cadastro",
                  style: Helper.getTheme(context).displaySmall
                ),
                const SizedBox(
                          height: 15,
                        ),
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            labelText: "Nome Completo",
                            hintText: "Nome Completo",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: "E-mail",
                            hintText: "E-mail",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            labelText: "Telefone",
                            hintText: "Telefone",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: "Senha",
                            hintText: "Senha",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key_rounded),
                            labelText: "Confirme sua senha",
                            hintText: "Confirme sua senha",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const Text(
                              "Cadastre-se",
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: Text(
                            "Ou",
                            style: Helper.getTheme(context).labelLarge
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Image(image: AssetImage(Helper.getAssetName("google.png", "logos")),width: 20,),
                            onPressed: (){}, 
                            label: Text(
                              "Registre-se com o Google",
                              style: Helper.getTheme(context).labelLarge
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Voce já tem uma conta ? ",
                                children: [
                                  const TextSpan(
                                    text: "Faça Login"
                                  )
                                ],
                                style: Helper.getTheme(context).labelLarge
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