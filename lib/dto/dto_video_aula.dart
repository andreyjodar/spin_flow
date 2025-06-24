class VideoAulaDTO {
  final int? id;
  final String nome;
  final String link;
  final bool ativo;

  VideoAulaDTO({
    this.id,
    required this.nome,
    required this.link,
    required this.ativo,
  });
}