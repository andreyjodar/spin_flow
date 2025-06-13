class AlunoDTO {
  int? id;
  String nome;
  String email;
  DateTime dataNascimento;
  String genero;
  String telefoneContato;
  String? perfilInstagram;
  String? perfilFacebook;
  String? perfilTiktok;
  bool ativo;

  AlunoDTO({
    int? id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
    required this.genero,
    required this.telefoneContato,
    this.perfilInstagram,
    this.perfilFacebook,
    this.perfilTiktok,
    required this.ativo,
  });
}
