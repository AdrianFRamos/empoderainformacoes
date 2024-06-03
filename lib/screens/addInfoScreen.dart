import 'dart:io';
import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AddInfoScreen extends StatefulWidget {
  AddInfoScreen({super.key});
  static const routeName = "/addInfoScreen";

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> uploadImage(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      var imageUrl = storage.ref(ref).putFile(file);
      return Future.value(imageUrl);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  selectUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await uploadImage(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          setState(() => uploading = false);
        }
      });
    }
  }

  void _submitForm() {
    final controller = InfoController.instance;
    if (controller.infoFormKey.currentState!.validate()) {
      controller.addNewInfo();
    }
  }

  Future<void> _launchMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress'); 
    if (!await launchUrl(url)) { 
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o Google Maps';
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final Uri phoneUrl = Uri.parse('tel:$phoneNumber');
    if (await launchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      throw 'Não foi possível fazer a ligação telefônica';
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
                    prefixIcon: Icon(
                      Icons.text_snippet,
                      color: Colors.black,
                    ), 
                    labelText: 'Grande área'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.pequeArea,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.text_snippet,
                      color: Colors.black,
                    ), 
                    labelText: 'Pequena área'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.titulo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.black,
                    ), 
                    labelText: 'Título'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(

                  controller: controller.descricao,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.book_sharp,
                      color: Colors.black,
                    ), 
                    labelText: 'Descrição'
                  ),
                  maxLines: null, 
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.endereco,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.map,
                      color: Colors.black,
                    ), 
                    labelText: 'Endereço',
                  ),
                  onTap: () => _launchMaps(controller.endereco.text),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.telefone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ), 
                    labelText: 'Telefone'
                  ),
                  onTap: () => _launchPhoneCall(controller.telefone.text),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.maisInfo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ), 
                    labelText: 'Mais informações'
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      uploading
                      ? const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ) 
                      : IconButton(
                        onPressed: selectUploadImage,
                        icon: const Icon(Icons.upload),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Salvar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
