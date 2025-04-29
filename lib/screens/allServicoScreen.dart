import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/addServicoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/servicoController.dart';
import '../models/servicoModel.dart';
import '../widgets/servicoWidget.dart';

class AllServicoScreen extends StatelessWidget {
  const AllServicoScreen({super.key});
  static const routeName = "/allServicoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServicoController());

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Serviços Cadastrados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listagem de Serviços',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => FutureBuilder(
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.allServicos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro ao buscar serviços: ${snapshot.error}'));
                    } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                      return Center(child: Text('Nenhum serviço encontrado'));
                    } else {
                      final servicos = snapshot.data as List<ServicoModel>;
                      return ListView.separated(
                        itemCount: servicos.length,
                        separatorBuilder: (context, index) => SizedBox(height: 12),
                        itemBuilder: (context, index) => ServicoWidget(
                          servico: servicos[index],
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
        onPressed: () => Get.to(() => AddServicoScreen()),
        label: Text('Novo Serviço'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
