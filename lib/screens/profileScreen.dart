import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/allContatoScreen.dart';
import 'package:empoderainformacoes/screens/allInfoScreen.dart';
import 'package:empoderainformacoes/screens/allServicoScreen.dart';
import 'package:empoderainformacoes/screens/updateprofileScreen.dart';
import 'package:empoderainformacoes/utils/helper.dart';
import 'package:empoderainformacoes/widgets/profileMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/authRepository.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profilescreen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: softPink,
        title: Text(
          "Perfil",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
            }, 
            icon: Icon(isDark? Icons.sunny : Icons.mode_night_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: softCream,
            padding:  const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(Helper.getAssetName('educacao.png', 'images'))),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), 
                          color: softPink,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Laphis - Empodera",
                  style: Theme.of(context).textTheme.headlineMedium
                ),
                Text(
                  "laphis@laphis.com",
                  style: Theme.of(context).textTheme.headlineSmall

                ),
                SizedBox(
                  height: 30,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: "Cadastrar Informações",
                  icon: Icons.info_outline,
                  onPress: () => Get.to(() => AllInfoScreen()), 
                ),
                ProfileMenuWidget(
                  title: "Cadastrar Contatos",
                  icon: Icons.info_outline,
                  onPress: () => Get.to(() => AllContatoScreen()), 
                ),
                ProfileMenuWidget(
                  title: "Cadastrar Serviços",
                  icon: Icons.info_outline,
                  onPress: () => Get.to(() => AllServicoScreen()), 
                ),
                Divider(),
                ProfileMenuWidget(
                  title: "Sair",
                  icon: Icons.output,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: (){
                    AuthRepository.instance.logout();
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
