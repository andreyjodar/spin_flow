class BandaArtistaDTO {
  final int? id;
  final String nome;
  final String? descricao;
  final String? link;
  final String? fotoPerfil;
  final bool ativo;

  BandaArtistaDTO({
    this.id,
    required this.nome,
    this.descricao,
    this.link,
    this.fotoPerfil,
    this.ativo = true,
  });
}