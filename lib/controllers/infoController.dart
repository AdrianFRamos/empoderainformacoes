import 'package:empoderainformacoes/models/informacoesModel.dart';
import 'package:empoderainformacoes/repository/infoRepository.dart';
import 'package:empoderainformacoes/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  static InfoController get instance => Get.find();

  final grandArea = TextEditingController();
  final pequeArea = TextEditingController();
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final endereco = TextEditingController();
  final telefone = TextEditingController();
  final maisInfo = TextEditingController();
  final TextEditingController _cleanController = TextEditingController();
  GlobalKey<FormState> infoFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<InfoModel> selecionarInfo = InfoModel.empty().obs;
  final infoRepository = Get.put(InfoRepository());

  Future<List<InfoModel>> allInfo() async {
    try {
      final informacoes = await infoRepository.fetchInfo();
      return informacoes;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future<List<InfoModel>> searchInfo(String query) async {
    try {
      final informacoes = await infoRepository.searchInfo(query);
      return informacoes;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future addNewInfo() async {
    try {
      if (!infoFormKey.currentState!.validate()) {
        return;
      }

      final informacoes = InfoModel(
        id: '',
        grandArea: grandArea.text.trim(),
        pequeArea: pequeArea.text.trim(),
        titulo: titulo.text.trim(),
        descricao: descricao.text.trim(),
        endereco: endereco.text.trim(),
        telefone: telefone.text.trim(),
        maisInfo: maisInfo.text.trim(),
        dateTime: DateTime.now(), // Adiciona a data/hora atual
      );
      final id = await infoRepository.addInfo(informacoes);
      informacoes.id = id;

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação adicionada com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não adicionada.');
    }
  }

  void loadInfo(InfoModel info) {
    grandArea.text = info.grandArea;
    pequeArea.text = info.pequeArea;
    titulo.text = info.titulo;
    descricao.text = info.descricao;
    endereco.text = info.endereco;
    telefone.text = info.telefone;
    maisInfo.text = info.maisInfo;
  }

  Future updateInfo(String id) async {
    try {
      if (!infoFormKey.currentState!.validate()) {
        return;
      }

      final informacoes = InfoModel(
        id: id,
        grandArea: grandArea.text.trim(),
        pequeArea: pequeArea.text.trim(),
        titulo: titulo.text.trim(),
        descricao: descricao.text.trim(),
        endereco: endereco.text.trim(),
        telefone: telefone.text.trim(),
        maisInfo: maisInfo.text.trim(),
        dateTime: DateTime.now(), // Adiciona a data/hora atual
      );

      await infoRepository.updateInfo(informacoes);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação atualizada com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não atualizada.');
    }
  }

  Future deleteInfo(String id) async {
    try {
      await infoRepository.deleteInfo(id);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação excluída com sucesso.');

      refreshData.toggle();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não excluída.');
    }
  }

  void resetFormField() {
    grandArea.clear();
    pequeArea.clear();
    titulo.clear();
    descricao.clear();
    endereco.clear();
    telefone.clear();
    maisInfo.clear();
    infoFormKey.currentState?.reset();
    _cleanController.clear();
  }
}
