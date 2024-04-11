import 'package:empoderainformacoes/models/informacoesModel.dart';
import 'package:empoderainformacoes/repository/infoRepository.dart';
import 'package:empoderainformacoes/utils/snackbar.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  static InfoController get instance => Get.find();

  final Rx<InfoModel> selecionarInfo = InfoModel.empty().obs;
  final infoRepository = Get.put(InfoRepository());

  Future<List<InfoModel>> allInfo() async {
    try {
      final informacoes = await infoRepository.fetchInfo();
      //selecionarInfo.value = informacoes.firstWhere((element) => element.selecionarInfo, orElse: () => InfoModel.empty());
      return informacoes;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }
}