import 'package:spin_flow/dto/associa%C3%A7%C3%B5es/dto_mix_musica.dart';

class MixAulaDTO {
  final int? id;
  final String nome;
  final DateTime? dataInicioValidade;
  final DateTime? dataFimValidade;
  final String? descricao;
  final List<MixMusicaDTO>? musicas;
  final bool ativo;

  MixAulaDTO({
    this.id,
    required this.nome,
    this.dataInicioValidade,
    this.dataFimValidade,
    this.descricao,
    this.musicas,
    this.ativo = true,
  });
}