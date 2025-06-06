import 'package:uuid/uuid.dart';

class SalaDTO {
  String? id;
  String nome;
  int capacidadeTotalBikes;
  int numeroFilas;
  int numeroBikesPorFila;
  bool ativo;

  SalaDTO({
    String? id,
    required this.nome,
    required this.capacidadeTotalBikes,
    required this.numeroFilas,
    required this.numeroBikesPorFila,
    required this.ativo,
  }) : id = id ?? const Uuid().v4();
}
