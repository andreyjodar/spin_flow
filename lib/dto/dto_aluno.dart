import 'package:uuid/uuid.dart';

class AlunoDTO {
  String? id;
  String nome;
  String email;
  DateTime dataNascimento;
  String genero;
  String telefoneContato;
  String perfilInstagram;
  String perfilFacebook;
  String perfilTiktok;
  bool ativo;

  AlunoDTO({
    String? id,
    required this.nome,
    required this.email,
    required this.dataNascimento,
    required this.genero,
    required this.telefoneContato,
    required this.perfilInstagram,
    required this.perfilFacebook,
    required this.perfilTiktok,
    required this.ativo,
  }) : id = id ?? const Uuid().v4();
}
