class MusicaDTO {
  final int? id;
  final String nome;
  final int artistaId;
  final List<int>? categoriasIds;
  final List<int>? videoAulasIds;
  final int? duracaoSegundos;
  final String? link;
  final String? descricao;
  final bool ativo;

  MusicaDTO({
    this.id,
    required this.nome,
    required this.artistaId,
    this.categoriasIds,
    this.videoAulasIds,
    this.duracaoSegundos,
    this.link,
    this.descricao,
    this.ativo = true,
  });
}