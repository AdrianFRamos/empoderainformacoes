import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void ligarPara(String telefone) async {
  final Uri url = Uri(scheme: 'tel', path: telefone);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    Get.snackbar('Erro', 'Não foi possível abrir o discador',
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }
}

