Considerando um projeto flutter utilizando sqflite gere um widget para listar dto de fabricante.
- para cada item, no canto a direita inserir ícone de excluir (vermelho) e alterar (laranjado)
- crie uma função para excluir que apresente o dto
- crie uma função para alterar que apresente o dto
- crie um mock de lista dados de dto de fabricante
- crie o mock antes da classe widget - defina os dados no contexto coeso, que seria fabricantes spinning
- o nome da classe deve ser ListaFabricante

considere o seguinte dto:

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
