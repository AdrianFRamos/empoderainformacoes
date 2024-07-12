import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:empoderainformacoes/screens/fourteenScreen.dart';
import '../models/informacoesModel.dart';

class ThirdScreen extends StatelessWidget {
  static const routeName = "/ThirdScreen";
  final String? pequeArea;
  final List<InfoModel> infoList;

  const ThirdScreen({Key? key, required this.infoList, this.pequeArea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Informações',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: palePink,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: softCream,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Informações sobre ${pequeArea ?? ''}',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: infoList.length,
              itemBuilder: (context, index) {
                final info = infoList[index];
                return InfoCard(info: info);
              },
            ),
          ),
        ],
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
    return Container(
      color: softCream,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        color: palePink,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                info.titulo,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                limitText(info.descricao, descriptionLimit),
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Data: ${info.dateTime != null ? formatDate(info.dateTime!) : ''}',
                style: GoogleFonts.montserrat(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FourteenScreen(info: info),
                      ),
                    );
                  },
                  child: Text(
                    'Leia mais',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String limitText(String text, int limit) {
    return text.length > limit ? '${text.substring(0, limit)}...' : text;
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
