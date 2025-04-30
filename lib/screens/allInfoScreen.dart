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

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Informações Cadastradas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listagem de Informações',
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => FutureBuilder(
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.allInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro ao buscar dados: ${snapshot.error}'));
                    } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                      return Center(child: Text('Nenhuma informação encontrada'));
                    } else {
                      final informacoes = snapshot.data as List<InfoModel>;
                      return ListView.separated(
                        itemCount: informacoes.length,
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemBuilder: (context, index) => InfoWidget(
                          informacoes: informacoes[index],
                        ),
                      );
                    }
                  },
                ),
              ),
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
