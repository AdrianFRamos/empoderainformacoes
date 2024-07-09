import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/homeBarWidget.dart';
import 'secondScreen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";
  const HomeScreen({Key? key});

  IconData getIconForGrandArea(String grandArea) {
    switch (grandArea.toLowerCase()) {
      case 'aposentadoria':
        return Icons.account_balance;
      case 'saude':
        return Icons.local_hospital;
      case 'educacao':
        return Icons.school;
      case 'profissional':
        return Icons.work;
      case 'comunidade':
        return Icons.monetization_on;
      default:
        return Icons.question_mark; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = Get.put(InfoController());

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Container(
        color: softCream,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Em que podemos ajudar?',
                  style: GoogleFonts.libreBaskerville(
                    color: Colors.black, 
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (infoController.refreshData.value) {
                    return FutureBuilder<List<InfoModel>>(
                      future: infoController.allInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro ao carregar dados'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('Nenhuma informação disponível'));
                        } else {
                          final informacoes = snapshot.data!;
                          final uniqueGrandAreas = informacoes.map((info) => info.grandArea).toSet().toList();
                          return Wrap(
                            children: uniqueGrandAreas.map((grandArea) => buildGridItem(grandArea)).toList(),
                          );
                        }
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(String grandArea) {
    final IconData icon = getIconForGrandArea(grandArea);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SecondScreen(grandArea: grandArea), transition: Transition.fadeIn);
        },
        child: Container(
          width: 180, 
          height: 150, 
          decoration: BoxDecoration(
            color: Color(0xFFFFC1CC),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Color(0xFFFFF2E2),
              ),
              SizedBox(height: 8),
              Text(
                grandArea,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
