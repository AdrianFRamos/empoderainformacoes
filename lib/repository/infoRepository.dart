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
      //final userId = AuthRepository.instance.firebaseUser!.uid;
      final currentInfo = await _db.collection('Informacoes').add(informacoes.toJson());
      return currentInfo.id;
    } catch (e) {
      throw 'Ocorreu algo de errado ao adicionar as informações. Tente novamente';
    }
  }
}