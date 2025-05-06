import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void abrirNoMaps(String endereco) async {
  final query = Uri.encodeComponent(endereco);
  final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    Get.snackbar('Erro', 'Não foi possível abrir o Maps',
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }
}
