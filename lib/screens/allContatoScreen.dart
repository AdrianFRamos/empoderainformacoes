import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/screens/addContatoScreen.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contatoController.dart';
import '../widgets/contatoWidget.dart';

class AllContatoScreen extends StatelessWidget {
  const AllContatoScreen({super.key});
  static const routeName = "/allContatoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContatoController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.carregarContatos();
    });

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
            SizedBox(height: 10),
            TextField(
              onChanged: controller.filtrarContatosPorNome,
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                final agrupados = controller.contatosAgrupadosPorCategoria;

                if (agrupados.isEmpty) {
                  return Center(child: Text('Nenhum contato encontrado'));
                }

                return ListView(
                  children: agrupados.entries.map((entry) {
                    final categoria = entry.key;
                    final contatos = entry.value;

                    return ExpansionTile(
                      title: Text(categoria, style: TextStyle(fontWeight: FontWeight.bold)),
                      children: contatos.map((contato) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: ContatoWidget(contato: contato),
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
        onPressed: () => Get.to(() => AddContatoScreen()),
        label: Text('Novo Contato'),
        icon: Icon(Icons.add),
      ),
    );
  }
}