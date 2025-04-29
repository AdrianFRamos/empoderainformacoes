import 'package:empoderainformacoes/models/contatoModel.dart';
import 'package:empoderainformacoes/repository/contatoRepository.dart';
import 'package:empoderainformacoes/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContatoController extends GetxController {
  static ContatoController get instance => Get.find();

  final nome = TextEditingController();
  final telefone = TextEditingController();
  final email = TextEditingController();
  final TextEditingController _cleanController = TextEditingController();
  GlobalKey<FormState> contatoFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<ContatoModel> selecionarContato = ContatoModel.empty().obs;
  final contatoRepository = Get.put(ContatoRepository());

  DateTime lastNotificationTimestamp = DateTime.now().subtract(Duration(days: 1));
  RxList<String> newContatos = <String>[].obs;

  Future<List<ContatoModel>> allContatos() async {
    try {
      final contatos = await contatoRepository.fetchContatos();
      return contatos;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future addNewContato() async {
    try {
      if (!contatoFormKey.currentState!.validate()) {
        return;
      }

      final contato = ContatoModel(
        id: '',
        nome: nome.text.trim(),
        telefone: telefone.text.trim(),
        email: email.text.trim(),
        dateTime: DateTime.now(),
      );

      final id = await contatoRepository.addContato(contato);
      contato.id = id;

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Contato adicionado com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Contato não adicionado.');
    }
  }

  void loadContato(ContatoModel contato) {
    nome.text = contato.nome;
    telefone.text = contato.telefone;
    email.text = contato.email;
  }

  Future updateContato(String id) async {
    try {
      if (!contatoFormKey.currentState!.validate()) {
        return;
      }

      final contato = ContatoModel(
        id: id,
        nome: nome.text.trim(),
        telefone: telefone.text.trim(),
        email: email.text.trim(),
        dateTime: DateTime.now(),
      );

      await contatoRepository.updateContato(contato);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Contato atualizado com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Contato não atualizado.');
    }
  }

  Future deleteContato(String id) async {
    try {
      await contatoRepository.deleteContato(id);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Contato excluído com sucesso.');

      refreshData.toggle();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Contato não excluído.');
    }
  }

  void resetFormField() {
    nome.clear();
    telefone.clear();
    email.clear();
    contatoFormKey.currentState?.reset();
    _cleanController.clear();
  }

  Future<List<String>> getNewContatos() async {
    try {
      final contatos = await allContatos();
      final novos = contatos
          .where((contato) => contato.dateTime!.isAfter(lastNotificationTimestamp))
          .map((contato) => contato.nome)
          .toSet()
          .toList();
      return novos;
    } catch (e) {
      return [];
    }
  }

  void markNotificationsAsRead() {
    lastNotificationTimestamp = DateTime.now();
  }
}
