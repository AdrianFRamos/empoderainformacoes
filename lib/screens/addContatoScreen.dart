import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class AddContatoScreen extends StatelessWidget {
  AddContatoScreen({super.key});
  static const routeName = "/addContatoScreen";

  final ContatoController controller = ContatoController.instance;

  void _submitForm() {
    if (controller.contatoFormKey.currentState!.validate()) {
      controller.addNewContato();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(
        showBackArrow: true, 
        title: Text('Novo Contato')
      ),
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
              key: controller.contatoFormKey,
              child: Card(
                color: lightPeach,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildInputField(controller.nome, 'Nome', Icons.person),
                      SizedBox(height: 15),
                      buildInputField(controller.telefone, 'Telefone', Icons.phone),
                      SizedBox(height: 15),
                      buildInputField(controller.email, 'Email', Icons.email),
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
          label: Text('Salvar Contato'),
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
