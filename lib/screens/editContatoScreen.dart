import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empoderainformacoes/controllers/contatoController.dart';
import 'package:empoderainformacoes/models/contatoModel.dart';

class EditContatoScreen extends StatefulWidget {
  final ContatoModel contato;

  EditContatoScreen({required this.contato});

  @override
  _EditContatoScreenState createState() => _EditContatoScreenState();
}

class _EditContatoScreenState extends State<EditContatoScreen> {
  final List<String> diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  final RxList<String> diasSelecionados = <String>[].obs;
  TimeOfDay? horaInicio;
  TimeOfDay? horaFim;

  final ContatoController contatoController = Get.find();

  @override
  void initState() {
    super.initState();
    contatoController.loadContato(widget.contato);

    final horarioStr = widget.contato.horario;
    final partes = horarioStr.split(':');
    if (partes.length == 2) {
      final dias = partes[0].split(',').map((d) => d.trim()).toList();
      diasSelecionados.addAll(dias);

      final horarios = partes[1].split('às');
      if (horarios.length == 2) {
        horaInicio = _parseTime(horarios[0].trim());
        horaFim = _parseTime(horarios[1].trim());
      }
    }
  }

  TimeOfDay _parseTime(String time) {
    final partes = time.split(':');
    return TimeOfDay(
      hour: int.parse(partes[0]),
      minute: int.parse(partes[1]),
    );
  }

  String horarioConcatenado(BuildContext context) {
    if (diasSelecionados.isEmpty || horaInicio == null || horaFim == null) return '';
    final dias = diasSelecionados.join(', ');
    final inicio = horaInicio!.format(context);
    final fim = horaFim!.format(context);
    return '$dias: $inicio às $fim';
  }

  void _submitForm() {
    contatoController.horario.text = horarioConcatenado(context);
    contatoController.updateContato(widget.contato.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: Text('Editar Contato'),
        backgroundColor: softPink,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: contatoController.contatoFormKey,
          child: Card(
            color: palePink,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField(contatoController.categoria, 'Categoria', Icons.list),
                  SizedBox(height: 15),
                  buildInputField(contatoController.nome, 'Nome', Icons.person),
                  SizedBox(height: 15),
                  buildInputField(contatoController.telefone, 'Telefone', Icons.phone),
                  SizedBox(height: 15),
                  buildInputField(contatoController.email, 'Email', Icons.email),
                  SizedBox(height: 15),
                  buildInputField(contatoController.endereco, 'Endereço', Icons.map),
                  SizedBox(height: 25),
                  Text('Dias de Atendimento:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Obx(() => Wrap(
                        spacing: 8,
                        children: diasDaSemana.map((dia) {
                          return FilterChip(
                            label: Text(dia),
                            selected: diasSelecionados.contains(dia),
                            onSelected: (value) {
                              setState(() {
                                value ? diasSelecionados.add(dia) : diasSelecionados.remove(dia);
                              });
                            },
                          );
                        }).toList(),
                      )),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: horaInicio ?? TimeOfDay.now(),
                          );
                          if (picked != null) setState(() => horaInicio = picked);
                        },
                        icon: Icon(Icons.access_time),
                        label: Text('Início'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: horaFim ?? TimeOfDay.now(),
                          );
                          if (picked != null) setState(() => horaFim = picked);
                        },
                        icon: Icon(Icons.access_time),
                        label: Text('Fim'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      ),
                    ],
                  ),
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
