import 'package:empoderainformacoes/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/informacoesModel.dart';
import '../widgets/infoDetailWidget.dart';
import '../widgets/infoDetailWithIconWidget.dart';

class FourteenScreen extends StatelessWidget {
  final InfoModel? info;
  static const routeName = "/FourteenScreen";

  const FourteenScreen({Key? key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          info?.titulo ?? 'Informações',
          style: GoogleFonts.bebasNeue(
            fontSize: 35,
          ),
        ),
        backgroundColor: palePink,
      ),
      backgroundColor: softCream,
      body: Container(
        margin: EdgeInsets.all(10),
        child: info != null ? ListView(
          children: [
            InfoDetailWidget(title: 'Titulo', content: info!.titulo),
            InfoDetailWidget(title: 'Descrição', content: info!.descricao),
            InfoDetailWithIconWidget(
              title: 'Endereço',
              content: info!.endereco,
              icon: Icons.location_on,
              onTap: () => _launchMaps(info!.endereco),
            ),
            InfoDetailWithIconWidget(
              title: 'Telefone',
              content: info!.telefone,
              icon: Icons.phone,
              onTap: () => _launchPhoneCall(info!.telefone),
            ),
            InfoDetailWidget(title: 'Mais Informações', content: info!.maisInfo),
          ],
        ) : Center(
          child: Text('Nenhuma informação disponível.'),
        ),
      ),
    );
  }

  Future<void> _launchMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
    if (!await launchUrl(url)) {
      throw 'Não foi possível abrir o Google Maps';
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final Uri phoneUrl = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(phoneUrl)) {
      throw 'Não foi possível fazer a ligação telefônica';
    }
  }
}
