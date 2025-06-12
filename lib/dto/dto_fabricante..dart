class FabricanteDTO {
  int? id;
  String nome;
  String? descricao;
  String? nomeContatoPrincipal;
  String? emailContato;
  String? telefoneContato;
  bool ativo;

  FabricanteDTO({
    int? id,
    required this.nome,
    this.descricao,
    this.nomeContatoPrincipal,
    this.emailContato,
    this.telefoneContato,
    required this.ativo,
  });
}
