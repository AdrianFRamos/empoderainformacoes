import 'package:cloud_firestore/cloud_firestore.dart';

class ServicoModel {
  String id;
  final String titulo;
  final String descricao;
  final String categoria;
  final DateTime? dateTime;

  ServicoModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.categoria,
    this.dateTime,
  });

  static ServicoModel empty() => ServicoModel(id: '', titulo: '', descricao: '', categoria: '', dateTime: null);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'categoria': categoria,
      'Datetime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
    };
  }

  factory ServicoModel.fromMap(Map<String, dynamic> data) {
    return ServicoModel(
      id: data['id'] as String,
      titulo: data['titulo'] as String,
      descricao: data['descricao'] as String,
      categoria: data['categoria'] as String,
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
    );
  }

  factory ServicoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ServicoModel(
      id: snapshot.id,
      titulo: data['titulo'] ?? '',
      descricao: data['descricao'] ?? '',
      categoria: data['categoria'] ?? '',
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
    );
  }
}
