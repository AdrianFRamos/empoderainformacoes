import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoderainformacoes/models/contatoModel.dart';
import 'package:get/get.dart';

class ContatoRepository extends GetxController {
  static ContatoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ContatoModel>> fetchContatos() async {
    try {
      final result = await _db.collection('Contatos').get();
      return result.docs.map((documentSnapshot) => ContatoModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Ocorreu algo de errado ao buscar os contatos. Tente novamente';
    }
  }

  Future<String> addContato(ContatoModel contato) async {
    try {
      final currentContato = await _db.collection('Contatos').add(contato.toJson());
      return currentContato.id;
    } catch (e) {
      throw 'Ocorreu algo de errado ao adicionar o contato. Tente novamente';
    }
  }

  Future<void> updateContato(ContatoModel contato) async {
    try {
      await _db.collection('Contatos').doc(contato.id).update(contato.toJson());
    } catch (e) {
      throw 'Ocorreu algo de errado ao atualizar o contato. Tente novamente';
    }
  }

  Future<void> deleteContato(String id) async {
    try {
      await _db.collection('Contatos').doc(id).delete();
    } catch (e) {
      throw 'Ocorreu algo de errado ao deletar o contato. Tente novamente';
    }
  }
}
