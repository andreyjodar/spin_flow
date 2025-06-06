import 'package:uuid/uuid.dart';

class TipoManutencaoDTO {
  String? id;
  String nome;
  String descricao;
  bool ativo;

  TipoManutencaoDTO({
    String? id,
    required this.nome,
    required this.descricao,
    required this.ativo,
  }) : id = id ?? const Uuid().v4();
}
