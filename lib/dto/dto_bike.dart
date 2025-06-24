class BikeDTO {
  int? id;
  String nome;
  String numeroSerie;
  int? fabricanteId; // ID do Fabricante (Associação 1:1)
  DateTime dataAquisicao;
  DateTime dataCadastroSistema;
  bool ativo;

  BikeDTO({
    int? id,
    required this.nome,
    required this.numeroSerie,
    required this.fabricanteId,
    required this.dataAquisicao,
    required this.dataCadastroSistema,
    required this.ativo,
  });
}
