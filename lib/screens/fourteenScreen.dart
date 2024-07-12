import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/colors.dart';
import '../models/informacoesModel.dart';

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
        child: info != null
            ? ListView(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info!.titulo,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${info?.dateTime ?? ''}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info!.descricao,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(),
                  _buildInfoRow(
                    context,
                    Icons.location_on,
                    'Endereço',
                    info!.endereco,
                    _launchMaps,
                  ),
                  _buildInfoRow(
                    context,
                    Icons.phone,
                    'Telefone',
                    info!.telefone,
                    _launchPhoneCall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mais informações: ${info!.maisInfo}',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text('Nenhuma informação disponível.'),
              ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String title, String content, Function(String) onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title: $content',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.blue),
            onPressed: () => onTap(content),
          ),
        ],
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
