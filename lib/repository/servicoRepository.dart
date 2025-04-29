import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoderainformacoes/models/servicoModel.dart';
import 'package:get/get.dart';

class ServicoRepository extends GetxController {
  static ServicoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ServicoModel>> fetchServicos() async {
    try {
      final result = await _db.collection('Servicos').get();
      return result.docs.map((documentSnapshot) => ServicoModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Ocorreu algo de errado ao buscar os serviços. Tente novamente';
    }
  }

  Future<String> addServico(ServicoModel servico) async {
    try {
      final currentServico = await _db.collection('Servicos').add(servico.toJson());
      return currentServico.id;
    } catch (e) {
      throw 'Ocorreu algo de errado ao adicionar o serviço. Tente novamente';
    }
  }

  Future<void> updateServico(ServicoModel servico) async {
    try {
      await _db.collection('Servicos').doc(servico.id).update(servico.toJson());
    } catch (e) {
      throw 'Ocorreu algo de errado ao atualizar o serviço. Tente novamente';
    }
  }

  Future<void> deleteServico(String id) async {
    try {
      await _db.collection('Servicos').doc(id).delete();
    } catch (e) {
      throw 'Ocorreu algo de errado ao deletar o serviço. Tente novamente';
    }
  }
}
