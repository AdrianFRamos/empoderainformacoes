import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/addContatoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contatoController.dart';
import '../models/contatoModel.dart';
import '../widgets/contatoWidget.dart';

class AllContatoScreen extends StatelessWidget {
  const AllContatoScreen({super.key});
  static const routeName = "/allContatoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContatoController());

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Contatos Cadastrados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listagem de Contatos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => FutureBuilder(
                  key: Key(controller.refreshData.value.toString()),
                  future: controller.allContatos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro ao buscar contatos: ${snapshot.error}'));
                    } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                      return Center(child: Text('Nenhum contato encontrado'));
                    } else {
                      final contatos = snapshot.data as List<ContatoModel>;
                      return ListView.separated(
                        itemCount: contatos.length,
                        separatorBuilder: (context, index) => SizedBox(height: 12),
                        itemBuilder: (context, index) => ContatoWidget(
                          contato: contatos[index],
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
        onPressed: () => Get.to(() => AddContatoScreen()),
        label: Text('Novo Contato'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
