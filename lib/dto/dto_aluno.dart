class AlunoDTO {
  final int? id;
  final String nome;
  final String email;
  final DateTime dataNascimento;
  final Genero genero;
  final String telefone;
  final String? instagram;
  final String? facebook;
  final String? tiktok;
  final bool ativo;

  AlunoDTO({
    this.id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
    required this.genero,
    required this.telefone,
    this.instagram,
    this.facebook,
    this.tiktok,
    this.ativo = true,
  });
}

enum Genero {
  masculino,
  feminino,
  outro,
  prefiroNaoInformar,
}