class TipoManutencaoDTO {
  final int? id;
  final String nome;
  final String? descricao;
  final bool ativo;

  TipoManutencaoDTO({
    this.id,
    required this.nome,
    this.descricao,
    this.ativo = true,
  });
}