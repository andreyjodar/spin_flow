import 'package:uuid/uuid.dart';

class FabricanteDTO {
  String? id;
  String nome;
  String descricao;
  String nomeContatoPrincipal;
  String emailContato;
  String telefoneContato;
  bool ativo;

  FabricanteDTO({
    String? id,
    required this.nome,
    required this.descricao,
    required this.nomeContatoPrincipal,
    required this.emailContato,
    required this.telefoneContato,
    required this.ativo,
  }) : id = id ?? const Uuid().v4();
}
