import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoDetail(title: 'Titulo', content: info.titulo),
                _InfoDetail(title: 'Descrição', content: info.descricao),
                _InfoDetail(title: 'Endereço', content: info.endereco),
                _InfoDetail(title: 'Telefone', content: info.telefone),
                _InfoDetail(title: 'Mais Informações', content: info.maisInfo),
              ],
            ),
            onTap: () {
              _handleTap(info);
            },
          );
        },
      ),
    );
  }

  void _handleTap(InfoModel info) async {
    if (await canLaunch(info.endereco)) {
      await launch(info.endereco);
    } else {
      throw 'Could not launch ${info.endereco}';
    }

    if (await canLaunch('tel:${info.telefone}')) {
      await launch('tel:${info.telefone}');
    } else {
      throw 'Could not launch tel:${info.telefone}';
    }
  }
}

class _InfoDetail extends StatelessWidget {
  final String title;
  final String content;

  const _InfoDetail({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
