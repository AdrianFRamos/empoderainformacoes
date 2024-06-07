import 'package:flutter/material.dart';
import '../models/informacoesModel.dart';

class ThirdScreen extends StatelessWidget {
  static const routeName = "/ThirdScreen";
  final List<InfoModel> infoList;

  const ThirdScreen({Key? key, required this.infoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: ListView.builder(
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          final info = infoList[index];
          return ListTile(
            title: Text(info.titulo),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descrição: ${info.descricao}'),
                Text('Endereço: ${info.endereco}'),
                Text('Telefone: ${info.telefone}'),
                Text('Mais informações: ${info.maisInfo}'),
              ],
            ),
            onTap: () {
              // Aqui você pode adicionar a lógica para lidar com o clique em um item
            },
          );
        },
      ),
    );
  }
}
