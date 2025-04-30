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

  void _submitForm() {
    servicoController.updateServico(servico.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Editar Serviço'),
        backgroundColor: palePink,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: servicoController.servicoFormKey,
          child: Card(
            color: palePink,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildInputField(servicoController.titulo, 'Título', Icons.title),
                  SizedBox(height: 15),
                  buildInputField(servicoController.descricao, 'Descrição', Icons.description, maxLines: 3),
                  SizedBox(height: 15),
                  buildInputField(servicoController.categoria, 'Categoria', Icons.category),
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
            backgroundColor: softPink,
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
