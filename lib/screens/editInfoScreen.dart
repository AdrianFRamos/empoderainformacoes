import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/models/informacoesModel.dart';

class EditInfoScreen extends StatelessWidget {
  final InfoModel info;

  EditInfoScreen({required this.info}) {
    final InfoController infoController = Get.find();
    infoController.loadInfo(info);
  }

  final InfoController infoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Informação'),
      ),
      body: Form(
        key: infoController.infoFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: infoController.grandArea,
                decoration: InputDecoration(labelText: 'Grande Área'),
              ),
              TextFormField(
                controller: infoController.pequeArea,
                decoration: InputDecoration(labelText: 'Pequena Área'),
              ),
              TextFormField(
                controller: infoController.titulo,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextFormField(
                controller: infoController.descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: infoController.endereco,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              TextFormField(
                controller: infoController.telefone,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: infoController.maisInfo,
                decoration: InputDecoration(labelText: 'Mais Informações'),
              ),
              ElevatedButton(
                onPressed: () {
                  infoController.updateInfo(info.id);
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
