import 'package:flutter/material.dart';

class TurmaDTO {
  final int? id;
  final String nome;
  final String? descricao;
  final List<DiaSemana> diasSemana;
  final TimeOfDay horaInicio;
  final int duracao;
  final int salaId; 
  final bool ativo;

  TurmaDTO({
    this.id,
    required this.nome,
    this.descricao,
    required this.diasSemana,
    required this.horaInicio,
    required this.duracao,
    required this.salaId,
    this.ativo = true
  });
}

enum DiaSemana {
  segunda,
  terca,
  quarta,
  quinta,
  sexta,
  sabado,
  domingo,
}