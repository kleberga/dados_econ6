import 'package:cloud_firestore/cloud_firestore.dart';

class DadosSeries {
  final String categoria;
  final String descricao;
  final String fonte;
  final String formato;
  final int idAssunto;
  final String localidades;
  final String metrica;
  final String nivelGeografico;
  final String nome;
  final String nomeCompleto;
  final String numero;
  final String periodicidade;
  final String urlAPI;


  DadosSeries({
    required this.categoria,
    required this.descricao,
    required this.fonte,
    required this.formato,
    required this.idAssunto,
    required this.localidades,
    required this.metrica,
    required this.nivelGeografico,
    required this.nome,
    required this.nomeCompleto,
    required this.numero,
    required this.periodicidade,
    required this.urlAPI
  });

  factory DadosSeries.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return DadosSeries(
      categoria: data['categoria'] ?? '',
      descricao: data['descricao'] ?? '',
      fonte: data['fonte'] ?? '',
      formato: data['formato'] ?? '',
      idAssunto: data['idAssunto'] ?? '',
      localidades: data['localidades'] ?? '',
      metrica: data['metrica'] ?? '',
      nivelGeografico: data['nivelGeografico'] ?? '',
      nome: data['nome'] ?? '',
      nomeCompleto: data['nomeCompleto'] ?? '',
      numero: data['numero'] ?? '',
      periodicidade: data['periodicidade'] ?? '',
      urlAPI: data['urlAPI'] ?? ''
    );
  }
}
