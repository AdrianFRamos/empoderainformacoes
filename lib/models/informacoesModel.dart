import 'package:cloud_firestore/cloud_firestore.dart';

class InfoModel {
  String id;
  final String grandArea;
  final String pequeArea;
  final String titulo;
  final String descricao;
  final String endereco;
  final String telefone;
  final String maisInfo;
  final DateTime? dateTime;

  InfoModel({
    required this.id,
    required this.grandArea,
    required this.pequeArea,
    required this.titulo,
    required this.descricao,
    required this.endereco,
    required this.telefone,
    required this.maisInfo,
    this.dateTime,
  });

  static InfoModel empty() => InfoModel(id: '', grandArea: '', pequeArea: '', titulo: '', descricao: '', endereco: '', telefone: '', maisInfo: '', dateTime: null);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grandArea': grandArea,
      'pequeArea': pequeArea,
      'titulo': titulo,
      'descricao': descricao,
      'endereco': endereco,
      'telefone': telefone,
      'maisInfo': maisInfo,
      'Datetime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> data) {
    print('Data recebida do Firestore: $data');
    return InfoModel(
      id: data['id'] as String,
      grandArea: data['grandArea'] as String,
      pequeArea: data['pequeArea'] as String,
      titulo: data['titulo'] as String,
      descricao: data['descricao'] as String,
      endereco: data['endereco'] as String,
      telefone: data['telefone'] as String,
      maisInfo: data['maisInfo'] as String,
      dateTime: data['Datetime'] != null ? (data['DateTime'] as Timestamp).toDate() : null,
    );
  }

  factory InfoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return InfoModel(
      id: snapshot.id,
      grandArea: data['grandArea'] ?? '',
      pequeArea: data['pequeArea'] ?? '',
      titulo: data['titulo'] ?? '',
      descricao: data['descricao'] ?? '',
      endereco: data['endereco'] ?? '',
      telefone: data['telefone']?.toString() ?? '',
      maisInfo: data['maisInfo'] ?? '',
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
    );
  }
}
