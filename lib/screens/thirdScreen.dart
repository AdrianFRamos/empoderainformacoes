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
                _InfoDetailWithIcon(
                  title: 'Endereço',
                  content: info.endereco,
                  icon: Icons.location_on,
                  onTap: () => _launchMaps(info.endereco),
                ),
                _InfoDetailWithIcon(
                  title: 'Telefone',
                  content: info.telefone,
                  icon: Icons.phone,
                  onTap: () => _launchPhoneCall(info.telefone),
                ),
                _InfoDetail(title: 'Mais Informações', content: info.maisInfo),
              ],
            ),
            onTap: () {
              _launchMaps(info.endereco);
              _launchPhoneCall(info.telefone);
            },
          );
        },
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

  Future<bool> launchUrl(Uri url) async {
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
      return true;
    }
    return false;
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

class _InfoDetailWithIcon extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback onTap;

  const _InfoDetailWithIcon({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
