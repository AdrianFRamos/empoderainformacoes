import 'package:empoderainformacoes/models/contatoModel.dart';
import 'package:empoderainformacoes/repository/contatoRepository.dart';
import 'package:empoderainformacoes/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContatoController extends GetxController {
  static ContatoController get instance => Get.find();

  final nome = TextEditingController();
  final categoria = TextEditingController();
  final telefone = TextEditingController();
  final email = TextEditingController();
  final endereco = TextEditingController();
  final horario = TextEditingController();

  final TextEditingController _cleanController = TextEditingController();
  GlobalKey<FormState> contatoFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<ContatoModel> selecionarContato = ContatoModel.empty().obs;
  final RxList<ContatoModel> todosContatos = <ContatoModel>[].obs;
  final RxList<ContatoModel> contatosFiltrados = <ContatoModel>[].obs;
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
        categoria: categoria.text.trim(),
        nome: nome.text.trim(),
        telefone: telefone.text.trim(),
        email: email.text.trim(),
        dateTime: DateTime.now(),
        endereco: endereco.text.trim(),
        horario: horario.text.trim(), 
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
    categoria.text = contato.categoria;
    telefone.text = contato.telefone;
    email.text = contato.email;
    endereco.text = contato.endereco;
    horario.text = contato.horario;
  }

  Future updateContato(String id) async {
    try {
      if (!contatoFormKey.currentState!.validate()) {
        return;
      }

      final contato = ContatoModel(
        id: id,
        categoria: categoria.text.trim(),
        nome: nome.text.trim(),
        telefone: telefone.text.trim(),
        email: email.text.trim(),
        dateTime: DateTime.now(),
        endereco: endereco.text.trim(),
        horario: horario.text.trim(), 
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
    categoria.clear();
    telefone.clear();
    email.clear();
    endereco.clear();
    horario.clear();
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

  void filtrarContatosPorNome(String termo) {
    if (termo.isEmpty) {
      contatosFiltrados.assignAll(todosContatos);
    } else {
      contatosFiltrados.assignAll(
        todosContatos.where(
          (c) => c.nome.toLowerCase().contains(termo.toLowerCase()),
        ),
      );
    }
  }

  Map<String, List<ContatoModel>> get contatosAgrupadosPorCategoria {
    final mapa = <String, List<ContatoModel>>{};
    for (var contato in contatosFiltrados) {
      mapa.putIfAbsent(contato.categoria, () => []).add(contato);
    }
    return mapa;
  }

  Future<void> carregarContatos() async {
    final lista = await contatoRepository.fetchContatos(); 
    todosContatos.assignAll(lista);
    contatosFiltrados.assignAll(lista);
  }

  void markNotificationsAsRead() {
    lastNotificationTimestamp = DateTime.now();
  }
}
