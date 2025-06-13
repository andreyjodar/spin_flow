class BikeDTO {
  String? id;
  String nome;
  String numeroSerie;
  String fabricanteId; // ID do Fabricante (Associação 1:1)
  DateTime dataAquisicao;
  DateTime dataCadastroSistema;
  bool ativo;

  BikeDTO({
    String? id,
    required this.nome,
    required this.numeroSerie,
    required this.fabricanteId,
    required this.dataAquisicao,
    required this.dataCadastroSistema,
    required this.ativo,
  });
}
