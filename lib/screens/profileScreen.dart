import 'package:empoderainformacoes/screens/allInfoScreen.dart';
import 'package:empoderainformacoes/screens/homeScreen.dart';
import 'package:empoderainformacoes/screens/infoScreen.dart';
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
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }, 
          icon: Icon(Icons.arrow_back_ios_new),
        ),
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
        child: Container(
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
                        color: Colors.pink[50],
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
                "Coding with T",
                style: Theme.of(context).textTheme.headlineMedium
              ),
              Text(
                "superAdmin@codingwith.com",
                style: Theme.of(context).textTheme.bodyMedium
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[50],
                    side: BorderSide.none,
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: "Configuração",
                icon: Icons.settings,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Detalhes",
                icon: Icons.pageview_outlined,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Privacidade do usuario",
                icon: Icons.privacy_tip,
                onPress: () {},
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
                title: "Informações",
                icon: Icons.info_outline,
                onPress: () => Get.to(() => InfoScreen()), 
              ),
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
        )
      ),
    );
  }
}
