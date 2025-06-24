
class FabricanteDTO {
  int? id;
  String nome;
  String descricao;
  String nomeContatoPrincipal;
  String emailContato;
  String telefoneContato;
  bool ativo;

  FabricanteDTO({
    int? id,
    required this.nome,
    required this.descricao,
    required this.nomeContatoPrincipal,
    required this.emailContato,
    required this.telefoneContato,
    required this.ativo,
  });
}
