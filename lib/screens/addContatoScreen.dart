import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class AddContatoScreen extends StatelessWidget {
  AddContatoScreen({super.key});
  static const routeName = "/addContatoScreen";

  final ContatoController controller = ContatoController.instance;

  // final List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  // final RxList<String> diasSelecionados = <String>[].obs;
  // TimeOfDay? horaInicio;
  // TimeOfDay? horaFim;

  // String horarioConcatenado(BuildContext context) {
  //   if (diasSelecionados.isEmpty || horaInicio == null || horaFim == null) return '';
  //   final dias = diasSelecionados.join(', ');
  //   final inicio = horaInicio!.format(context);
  //   final fim = horaFim!.format(context);
  //   return '$dias: $inicio às $fim';
  // }


  void _submitForm() {
    if (controller.contatoFormKey.currentState!.validate()) {
      // controller.horario.text = horarioConcatenado(Get.context!);
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
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: controller.contatoFormKey,
              child: Card(
                color: palePink,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField(controller.categoria, 'Categoria', Icons.list),
                      SizedBox(height: 15),
                      buildInputField(controller.nome, 'Nome', Icons.person),
                      SizedBox(height: 15),
                      buildInputField(controller.telefone, 'Telefone', Icons.phone),
                      SizedBox(height: 15),
                      buildInputField(controller.email, 'Email', Icons.email),
                      SizedBox(height: 15),
                      buildInputField(controller.endereco, 'Endereço', Icons.map),
                      SizedBox(height: 15),
                      buildInputField(controller.horario, 'Horário de Atendimento', Icons.access_time),
                      SizedBox(height: 25),
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
            backgroundColor: softPink,
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
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
