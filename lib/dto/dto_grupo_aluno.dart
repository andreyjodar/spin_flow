class GrupoAlunoDTO {
  final int? id;
  final String nome;
  final String? descricao;
  final List<int>? alunosIds;
  final bool ativo;

  GrupoAlunoDTO({
    this.id,
    required this.nome,
    this.descricao,
    this.alunosIds,
    this.ativo = true,
  });
}