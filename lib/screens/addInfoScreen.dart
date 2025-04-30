import 'dart:io';
import 'package:empoderainformacoes/const/colors.dart';
import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddInfoScreen extends StatefulWidget {
  AddInfoScreen({super.key});
  static const routeName = "/addInfoScreen";

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> uploadImage(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  void _submitForm() {
    final controller = InfoController.instance;
    if (controller.infoFormKey.currentState!.validate()) {
      controller.addNewInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = InfoController.instance;

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBarWidget(showBackArrow: true, title: Text('Nova Informação')),
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
              key: controller.infoFormKey,
              child: Card(
                color: palePink,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildInputField(controller.grandArea, 'Grande Área', Icons.text_snippet),
                      SizedBox(height: 15),
                      buildInputField(controller.pequeArea, 'Pequena Área', Icons.text_snippet),
                      SizedBox(height: 15),
                      buildInputField(controller.titulo, 'Título', Icons.title),
                      SizedBox(height: 15),
                      buildInputField(controller.descricao, 'Descrição', Icons.book, maxLines: 3),
                      SizedBox(height: 15),
                      buildInputField(controller.endereco, 'Endereço', Icons.map),
                      SizedBox(height: 15),
                      buildInputField(controller.telefone, 'Telefone', Icons.phone),
                      SizedBox(height: 15),
                      buildInputField(controller.maisInfo, 'Mais Informações', Icons.add),
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
          label: Text('Salvar Informação'),
          style: ElevatedButton.styleFrom(
            backgroundColor: softPink,
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
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
