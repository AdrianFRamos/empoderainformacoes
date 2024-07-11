import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fourteenScreen.dart';
import '../models/informacoesModel.dart';

class ThirdScreen extends StatelessWidget {
  static const routeName = "/ThirdScreen";
  final List<InfoModel> infoList;

  const ThirdScreen({Key? key, required this.infoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informações',
          style: GoogleFonts.bebasNeue(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        backgroundColor: palePink,
      ),
      backgroundColor: softCream,
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: infoList.length,
          itemBuilder: (context, index) {
            final info = infoList[index];
            return InfoCard(info: info);
          },
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final InfoModel info;
  static const int descriptionLimit = 100; 
  const InfoCard({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: softPink,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          info.titulo,
          style: GoogleFonts.libreBaskerville(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        subtitle: Text(
          limitText(info.descricao, descriptionLimit),
          style: GoogleFonts.libreBaskerville(
            color: Colors.black,
            fontSize: 18
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FourteenScreen(info: info),
            ),
          );
        },
      ),
    );
  }

  String limitText(String text, int limit) {
    return text.length > limit ? '${text.substring(0, limit)}...' : text;
  }
}
