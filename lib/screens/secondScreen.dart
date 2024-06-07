import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../screens/thirdScreen.dart';

class SecondScreen extends StatelessWidget {
  static const routeName = "/SecondScreen";
  final String? grandArea;

  const SecondScreen({Key? key, this.grandArea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = InfoController.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(grandArea ?? 'Erro ao carregar dados'),
      ),
      body: FutureBuilder<List<InfoModel>>(
        future: infoController.allInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma informação disponível'));
          } else {
            final informacoes = snapshot.data!;
            final uniqueSmallAreas = informacoes
                .where((info) => info.grandArea == grandArea)
                .map((info) => info.pequeArea)
                .toSet()
                .toList();
            return ListView.builder(
              itemCount: uniqueSmallAreas.length,
              itemBuilder: (context, index) {
                final pequeArea = uniqueSmallAreas[index];
                return buildGridItem(pequeArea: pequeArea, infoList: informacoes.where((info) => info.pequeArea == pequeArea).toList());
              },
            );
          }
        },
      ),
    );
  }

  Widget buildGridItem({required String pequeArea, required List<InfoModel> infoList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
      child: GestureDetector(
        onTap: () {
          Get.to(() => ThirdScreen(infoList: infoList), transition: Transition.fadeIn);
        },
        child: Container(
          decoration: BoxDecoration(
            color: softOrange, 
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pequeArea,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), 
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
