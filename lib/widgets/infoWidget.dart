import 'package:empoderainformacoes/models/informacoesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infoController.dart';
import '../screens/editInfoScreen.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.informacoes});

  final InfoModel informacoes;

  @override
  Widget build(BuildContext context) {
    final infoController = Get.find<InfoController>();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 45, // Adjust the position to make space for the delete icon
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () {
                    infoController.loadInfo(informacoes);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditInfoScreen(info: informacoes),
                    ));
                  },
                ),
              ),
              Positioned(
                right: 5,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () async {
                    bool confirmDelete = await _showConfirmationDialog(context);
                    if (confirmDelete) {
                      await infoController.deleteInfo(informacoes.id);
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    informacoes.grandArea,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 5),
                  Text(
                    informacoes.pequeArea,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    informacoes.titulo,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar exclusão'),
        content: Text('Tem certeza de que deseja excluir esta informação?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('Excluir'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    ) ?? false;
  }
}
