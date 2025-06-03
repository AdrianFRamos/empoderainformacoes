import 'package:empoderainformacoes/screens/editContatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/contatoController.dart';

class SelecionarContatoScreen extends StatelessWidget {
  final ContatoController contatoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Selecionar Contato'),
        backgroundColor: softPink,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: contatoController.filtrarContatosPorNome,
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final agrupados = contatoController.contatosAgrupadosPorCategoria;
              return ListView(
                children: agrupados.entries.map((entry) {
                  final categoria = entry.key;
                  final contatos = entry.value;
                  return ExpansionTile(
                    title: Text(categoria, style: TextStyle(fontWeight: FontWeight.bold)),
                    children: contatos.map((contato) {
                      return ListTile(
                        title: Text(contato.nome),
                        subtitle: Text(contato.telefone),
                        onTap: () {
                          Get.to(() => EditContatoScreen(contato: contato));
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
