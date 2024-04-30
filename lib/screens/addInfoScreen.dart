import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class AddInfoScreen extends StatelessWidget {
  const AddInfoScreen({super.key});
  static const routeName = "/addInfoScreen";

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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: Text("Salvar")
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}