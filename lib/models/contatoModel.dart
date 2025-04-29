import 'package:cloud_firestore/cloud_firestore.dart';

class ContatoModel {
  String id;
  final String nome;
  final String telefone;
  final String email;
  final DateTime? dateTime;

  ContatoModel({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    this.dateTime,
  });

  static ContatoModel empty() => ContatoModel(id: '', nome: '', telefone: '', email: '', dateTime: null);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'Datetime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
    };
  }

  factory ContatoModel.fromMap(Map<String, dynamic> data) {
    return ContatoModel(
      id: data['id'] as String,
      nome: data['nome'] as String,
      telefone: data['telefone'] as String,
      email: data['email'] as String,
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
    );
  }

  factory ContatoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ContatoModel(
      id: snapshot.id,
      nome: data['nome'] ?? '',
      telefone: data['telefone']?.toString() ?? '',
      email: data['email'] ?? '',
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
    );
  }
}
