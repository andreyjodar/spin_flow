class TipoManutencaoDTO {
  String? id;
  String nome;
  String descricao;
  bool ativo;

  TipoManutencaoDTO({
    this.id,
    required this.nome,
    required this.descricao,
    required this.ativo,
  });
}
