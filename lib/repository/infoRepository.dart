import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoderainformacoes/models/informacoesModel.dart';
import 'package:get/get.dart';

class InfoRepository extends GetxController {
  static InfoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<InfoModel>> fetchInfo() async {
    try {
      final result = await _db.collection('Informacoes').get();
      return result.docs.map((documentSnapshot) => InfoModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Ocorreu algo de errado ao buscar as informações. Tente novamente';
    }
  }

  Future<String> addInfo(InfoModel informacoes) async {
    try {
      final currentInfo = await _db.collection('Informacoes').add(informacoes.toJson());
      return currentInfo.id;
    } catch (e) {
      throw 'Ocorreu algo de errado ao adicionar as informações. Tente novamente';
    }
  }

  Future<void> updateInfo(InfoModel info) async {
    try {
      await _db.collection('Informacoes').doc(info.id).update(info.toJson());
    } catch (e) {
      throw 'Ocorreu algo de errado ao atualizar as informações. Tente novamente';
    }
  }

  Future<void> deleteInfo(String id) async {
    try {
      await _db.collection('Informacoes').doc(id).delete();
    } catch (e) {
      throw 'Ocorreu algo de errado ao deletar as informações. Tente novamente';
    }
  }

  Future<List<InfoModel>> searchInfo(String query) async {
    try {
      List<InfoModel> infoList = [];

      final normalizedQuery = query.trim().toLowerCase();

      final grandAreaResult = await _db.collection('Informacoes')
          .where('grandArea', isGreaterThanOrEqualTo: normalizedQuery)
          .where('grandArea', isLessThanOrEqualTo: normalizedQuery + '\uf8ff')
          .get();

      infoList.addAll(grandAreaResult.docs.map((documentSnapshot) => InfoModel.fromDocumentSnapshot(documentSnapshot)).toList());

      if (infoList.isEmpty) {
        final pequeAreaResult = await _db.collection('Informacoes')
            .where('pequeArea', isGreaterThanOrEqualTo: normalizedQuery)
            .where('pequeArea', isLessThanOrEqualTo: normalizedQuery + '\uf8ff')
            .get();

        infoList.addAll(pequeAreaResult.docs.map((documentSnapshot) => InfoModel.fromDocumentSnapshot(documentSnapshot)).toList());
      }

      if (infoList.isEmpty) {
        final tituloResult = await _db.collection('Informacoes')
            .where('titulo', isGreaterThanOrEqualTo: normalizedQuery)
            .where('titulo', isLessThanOrEqualTo: normalizedQuery + '\uf8ff')
            .get();

        infoList.addAll(tituloResult.docs.map((documentSnapshot) => InfoModel.fromDocumentSnapshot(documentSnapshot)).toList());
      }

      return infoList;
    } catch (e) {
      throw 'Ocorreu algo de errado ao buscar as informações. Tente novamente';
    }
  }


}
