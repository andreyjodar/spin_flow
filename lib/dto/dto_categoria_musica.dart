class CategoriaMusicaDTO {
  final int? id;
  final String nome;
  final String? descricao;
  final bool ativo;

  CategoriaMusicaDTO({
    this.id,
    required this.nome,
    this.descricao,
    this.ativo = true,
  });
}