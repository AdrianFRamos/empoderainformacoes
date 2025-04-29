import 'package:empoderainformacoes/models/servicoModel.dart';
import 'package:empoderainformacoes/repository/servicoRepository.dart';
import 'package:empoderainformacoes/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicoController extends GetxController {
  static ServicoController get instance => Get.find();

  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final categoria = TextEditingController();
  final TextEditingController _cleanController = TextEditingController();
  GlobalKey<FormState> servicoFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<ServicoModel> selecionarServico = ServicoModel.empty().obs;
  final servicoRepository = Get.put(ServicoRepository());

  DateTime lastNotificationTimestamp = DateTime.now().subtract(Duration(days: 1));
  RxList<String> newServicos = <String>[].obs;

  Future<List<ServicoModel>> allServicos() async {
    try {
      final servicos = await servicoRepository.fetchServicos();
      return servicos;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future addNewServico() async {
    try {
      if (!servicoFormKey.currentState!.validate()) {
        return;
      }

      final servico = ServicoModel(
        id: '',
        titulo: titulo.text.trim(),
        descricao: descricao.text.trim(),
        categoria: categoria.text.trim(),
        dateTime: DateTime.now(),
      );

      final id = await servicoRepository.addServico(servico);
      servico.id = id;

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Serviço adicionado com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Serviço não adicionado.');
    }
  }

  void loadServico(ServicoModel servico) {
    titulo.text = servico.titulo;
    descricao.text = servico.descricao;
    categoria.text = servico.categoria;
  }

  Future updateServico(String id) async {
    try {
      if (!servicoFormKey.currentState!.validate()) {
        return;
      }

      final servico = ServicoModel(
        id: id,
        titulo: titulo.text.trim(),
        descricao: descricao.text.trim(),
        categoria: categoria.text.trim(),
        dateTime: DateTime.now(),
      );

      await servicoRepository.updateServico(servico);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Serviço atualizado com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Serviço não atualizado.');
    }
  }

  Future deleteServico(String id) async {
    try {
      await servicoRepository.deleteServico(id);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Serviço excluído com sucesso.');

      refreshData.toggle();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Serviço não excluído.');
    }
  }

  void resetFormField() {
    titulo.clear();
    descricao.clear();
    categoria.clear();
    servicoFormKey.currentState?.reset();
    _cleanController.clear();
  }

  Future<List<String>> getNewServicos() async {
    try {
      final servicos = await allServicos();
      final novos = servicos
          .where((servico) => servico.dateTime!.isAfter(lastNotificationTimestamp))
          .map((servico) => servico.titulo)
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
