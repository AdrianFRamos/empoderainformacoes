import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          grandArea ?? 'Erro ao carregar dados',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: palePink,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: softCream,
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
                final infoList = informacoes.where((info) => info.pequeArea == pequeArea).toList();
                return buildGridItem(pequeArea: pequeArea, infoList: infoList);
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
          Get.to(
            () => ThirdScreen(infoList: infoList, pequeArea: pequeArea),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: palePink,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pequeArea,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
