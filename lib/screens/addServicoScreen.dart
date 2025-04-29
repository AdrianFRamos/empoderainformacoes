import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/servicoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class AddServicoScreen extends StatelessWidget {
  AddServicoScreen({super.key});
  static const routeName = "/addServicoScreen";

  final ServicoController controller = ServicoController.instance;

  void _submitForm() {
    if (controller.servicoFormKey.currentState!.validate()) {
      controller.addNewServico();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Novo Serviço')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preencha os dados abaixo:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              key: controller.servicoFormKey,
              child: Card(
                color: lightPeach,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildInputField(controller.titulo, 'Título', Icons.title),
                      SizedBox(height: 15),
                      buildInputField(controller.descricao, 'Descrição', Icons.description, maxLines: 3),
                      SizedBox(height: 15),
                      buildInputField(controller.categoria, 'Categoria', Icons.category),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        child: ElevatedButton.icon(
          onPressed: _submitForm,
          icon: Icon(Icons.save),
          label: Text('Salvar Serviço'),
          style: ElevatedButton.styleFrom(
            backgroundColor: softOrange,
            minimumSize: Size(double.infinity, 50),
            textStyle: TextStyle(fontSize: 18),
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
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
