import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empoderainformacoes/controllers/servicoController.dart';
import 'package:empoderainformacoes/models/servicoModel.dart';

class EditServicoScreen extends StatelessWidget {
  final ServicoModel servico;

  EditServicoScreen({required this.servico}) {
    final ServicoController servicoController = Get.find();
    servicoController.loadServico(servico);
  }

  final ServicoController servicoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Editar Serviço'),
        backgroundColor: palePink,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Form(
        key: servicoController.servicoFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: servicoController.titulo,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextFormField(
                controller: servicoController.descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              TextFormField(
                controller: servicoController.categoria,
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
              ElevatedButton(
                onPressed: () {
                  servicoController.updateServico(servico.id);
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
