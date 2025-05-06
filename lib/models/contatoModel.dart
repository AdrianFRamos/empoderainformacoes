import 'package:cloud_firestore/cloud_firestore.dart';

class ContatoModel {
  String id;
  final String categoria;
  final String nome;
  final String telefone;
  final String email;
  final DateTime? dateTime;
  final String endereco;

  ContatoModel({
    required this.id,
    required this.categoria,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.endereco,
    this.dateTime,
  });

  static ContatoModel empty() => ContatoModel(id: '', categoria:'', nome: '', telefone: '', email: '', dateTime: null, endereco: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'telefone': telefone,
      'email': email,
      'Datetime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
      'endereco': endereco,
    };
  }

  factory ContatoModel.fromMap(Map<String, dynamic> data) {
    return ContatoModel(
      id: data['id'] as String,
      categoria: data['categoria'] as String,
      nome: data['nome'] as String,
      telefone: data['telefone'] as String,
      email: data['email'] as String,
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
      endereco: data['endereco'] as String,
    );
  }

  factory ContatoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ContatoModel(
      id: snapshot.id,
      categoria: data['categoria'] ?? '',
      nome: data['nome'] ?? '',
      telefone: data['telefone']?.toString() ?? '',
      email: data['email'] ?? '',
      dateTime: data['Datetime'] != null ? (data['Datetime'] as Timestamp).toDate() : null,
      endereco: data['endereco'] ?? '',
    );
  }
}
