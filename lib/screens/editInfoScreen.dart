import 'package:empoderainformacoes/const/colors.dart';
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

  void _submitForm() {
    infoController.updateInfo(info.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Editar Informação'),
        backgroundColor: softPink,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: infoController.infoFormKey,
          child: Card(
            color: palePink,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildInputField(infoController.grandArea, 'Grande Área', Icons.text_snippet),
                  SizedBox(height: 15),
                  buildInputField(infoController.pequeArea, 'Pequena Área', Icons.text_snippet),
                  SizedBox(height: 15),
                  buildInputField(infoController.titulo, 'Título', Icons.title),
                  SizedBox(height: 15),
                  buildInputField(infoController.descricao, 'Descrição', Icons.book, maxLines: 3),
                  SizedBox(height: 15),
                  buildInputField(infoController.endereco, 'Endereço', Icons.map),
                  SizedBox(height: 15),
                  buildInputField(infoController.telefone, 'Telefone', Icons.phone),
                  SizedBox(height: 15),
                  buildInputField(infoController.maisInfo, 'Mais Informações', Icons.add),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        child: ElevatedButton.icon(
          onPressed: _submitForm,
          icon: Icon(Icons.save),
          label: Text('Salvar Alterações'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            textStyle: TextStyle(fontSize: 18),
            backgroundColor: softPink
          ),
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
