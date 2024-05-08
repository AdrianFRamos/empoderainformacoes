import 'dart:io';

import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddInfoScreen extends StatelessWidget {
  AddInfoScreen({super.key});
  static const routeName = "/addInfoScreen";

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> uploadImage(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  selectUploadImage() async {
    XFile? file = await getImage();
    if(file != null){
      await uploadImage(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = InfoController.instance;

    return Scaffold(
      appBar: AppBarWidget(showBackArrow: true, title: Text('Adicione uma nova informação')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: controller.infoFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: controller.grandArea,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'Grande area'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.pequeArea,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'Pequena area'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.titulo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'Titulo'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.descricao,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'descricao'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.endereco,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'endereco'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.telefone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'Telefone'
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller.maisInfo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervisor_account), 
                    labelText: 'Mais informacoes'
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: selectUploadImage,
                        icon: const Icon(Icons.upload),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          InfoController.instance.addNewInfo();
                        },
                        child: Text("Salvar"),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}