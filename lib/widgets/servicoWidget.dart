import 'package:empoderainformacoes/models/servicoModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/servicoController.dart';
import '../screens/editServicoScreen.dart';

class ServicoWidget extends StatelessWidget {
  const ServicoWidget({super.key, required this.servico});

  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    final servicoController = Get.find<ServicoController>();

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
                right: 45,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    servicoController.loadServico(servico);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditServicoScreen(servico: servico),
                    ));
                  },
                ),
              ),
              Positioned(
                right: 5,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    bool confirmDelete = await _showConfirmationDialog(context);
                    if (confirmDelete) {
                      await servicoController.deleteServico(servico.id);
                    }
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    servico.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 5),
                  Text(
                    servico.categoria,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    servico.descricao,
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
        content: Text('Tem certeza de que deseja excluir este serviço?'),
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
