import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/addInfoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/infoWidget.dart';

class AllInfoScreen extends StatelessWidget {
  const AllInfoScreen({super.key});
  static const routeName = "/allInfoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.carregarInformacoes();
    });

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Informações Cadastradas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Listagem de Informações',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              onChanged: controller.filtrarPorTitulo,
              decoration: InputDecoration(
                hintText: 'Buscar por título...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                final agrupadas = controller.agrupadasPorGrandArea;
                if (agrupadas.isEmpty) {
                  return Center(child: Text('Nenhuma informação encontrada'));
                }
                return ListView(
                  children: agrupadas.entries.map((entry) {
                    final grupo = entry.key;
                    final infos = entry.value;

                    return ExpansionTile(
                      title: Text(grupo, style: TextStyle(fontWeight: FontWeight.bold)),
                      children: infos.map((info) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: InfoWidget(informacoes: info),
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: softPink,
        onPressed: () => Get.to(() => AddInfoScreen()),
        label: Text('Nova Informação'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
