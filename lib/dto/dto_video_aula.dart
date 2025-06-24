
class VideoAulaDTO {
  int? id;
  String nome;
  String linkVideo;
  bool ativo;

  VideoAulaDTO({
    int? id,
    required this.nome,
    required this.linkVideo,
    required this.ativo,
  });
}
