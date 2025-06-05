class VideoAulaDTO {
  String? id;
  String nome;
  String linkVideo;
  bool ativo;

  VideoAulaDTO({
    this.id,
    required this.nome,
    required this.linkVideo,
    required this.ativo,
  });

  // Método para converter para Map (útil para enviar a APIs, banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'link_video': linkVideo,
      'ativo': ativo,
    };
  }

  // Método para criar um DTO a partir de um Map
  factory VideoAulaDTO.fromMap(Map<String, dynamic> map) {
    return VideoAulaDTO(
      id: map['id'],
      nome: map['nome'],
      linkVideo: map['link_video'],
      ativo: map['ativo'],
    );
  }
}
