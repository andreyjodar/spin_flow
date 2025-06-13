import 'package:flutter/material.dart';
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

  @override
  String toString() {
    return '''
      ID: $id
      Nome: $nome
      Capacidade Total: $capacidadeTotalBikes bikes
      Disposição: $numeroFilas filas de $numeroBikesPorFila bikes
      Ativo: $ativo
    ''';
  }
}

final List<SalaDTO> mockSalas = [
  SalaDTO(
    nome: 'Sala Power',
    capacidadeTotalBikes: 20,
    numeroFilas: 4,
    numeroBikesPorFila: 5,
    ativo: true,
  ),
  SalaDTO(
    nome: 'Sala Zen',
    capacidadeTotalBikes: 12,
    numeroFilas: 3,
    numeroBikesPorFila: 4,
    ativo: true,
  ),
  SalaDTO(
    nome: 'Sala Cardio Max',
    capacidadeTotalBikes: 25,
    numeroFilas: 5,
    numeroBikesPorFila: 5,
    ativo: true,
  ),
  SalaDTO(
    nome: 'Sala Manutenção',
    capacidadeTotalBikes: 10,
    numeroFilas: 2,
    numeroBikesPorFila: 5,
    ativo: false,
  ),
];
