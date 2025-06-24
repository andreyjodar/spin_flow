class BikeDTO {
  final int? id;
  final String nome;
  final String? numeroSerie;
  final int fabricanteId;
  final DateTime dataAquisicao;
  final DateTime dataCadastro;
  final bool ativo;

  BikeDTO({
    this.id,
    required this.nome,
    this.numeroSerie,
    required this.fabricanteId,
    required this.dataAquisicao,
    DateTime? dataCadastro,
    this.ativo = true,
  }) : dataCadastro = dataCadastro ?? DateTime.now();
}