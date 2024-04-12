import 'package:empoderainformacoes/controllers/infoController.dart';
import 'package:empoderainformacoes/models/informacoesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.informacoes, required this.onTap});

  final InfoModel informacoes;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    final controller = InfoController.instance;

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(double.infinity), 
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 5,
              top: 0,
              child: Icon(Icons.bookmark)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Admin",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 5),
                Text(
                  "Grande Area",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  "Pequena area",
                  softWrap: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}