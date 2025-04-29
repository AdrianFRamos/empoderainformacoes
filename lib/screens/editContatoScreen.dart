import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/models/contatoModel.dart';

class EditContatoScreen extends StatelessWidget {
  final ContatoModel contato;

  EditContatoScreen({required this.contato}) {
    final ContatoController contatoController = Get.find();
    contatoController.loadContato(contato);
  }

  final ContatoController contatoController = Get.find();

  void _submitForm() {
    contatoController.updateContato(contato.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Editar Contato'),
        backgroundColor: palePink,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: contatoController.contatoFormKey,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildInputField(contatoController.nome, 'Nome', Icons.person),
                  SizedBox(height: 15),
                  buildInputField(contatoController.telefone, 'Telefone', Icons.phone),
                  SizedBox(height: 15),
                  buildInputField(contatoController.email, 'Email', Icons.email),
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
            backgroundColor: softOrange,
            minimumSize: Size(double.infinity, 50),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
