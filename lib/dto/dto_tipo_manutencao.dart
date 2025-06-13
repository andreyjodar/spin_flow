import 'package:uuid/uuid.dart';

class TipoManutencaoDTO {
  int? id;
  String nome;
  String descricao;
  bool ativo;

  TipoManutencaoDTO({
    int? id,
    required this.nome,
    required this.descricao,
    required this.ativo,
  });
}
