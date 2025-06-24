import 'package:flutter_application_1/dto/dto_tipo_manutencao.dart';
import 'package:flutter_application_1/banco/sqlite/conexao.dart';

class DAOTipoManutencao {
  // Definição das queries SQL como atributos de instância
  final String _sqlInsert =
      'INSERT INTO tipo_manutencao (id, nome, descricao, ativo) VALUES (?, ?, ?, ?)';
  final String _sqlUpdate =
      'UPDATE tipo_manutencao SET nome = ?, descricao = ?, ativo = ? WHERE id = ?';
  final String _sqlSelectAll =
      'SELECT id, nome, descricao, ativo FROM tipo_manutencao';
  final String _sqlSelectById =
      'SELECT id, nome, descricao, ativo FROM tipo_manutencao WHERE id = ?';
  final String _sqlDelete = 'DELETE FROM tipo_manutencao WHERE id = ?';

  /// Converte um objeto [TipoManutencaoDTO] para um [Map] para ser salvo no banco.
  Map<String, dynamic> _toMap(TipoManutencaoDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'descricao': dto.descricao,
      'ativo': dto.ativo ? 1 : 0, // SQLite não tem tipo booleano (usa 0 e 1)
    };
  }

  /// Converte um [Map] vindo do banco de dados para um [TipoManutencaoDTO].
  TipoManutencaoDTO _fromMap(Map<String, dynamic> map) {
    return TipoManutencaoDTO(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      ativo: map['ativo'] == 1, // Converte de inteiro para booleano
    );
  }

  /// Salva ou altera um registro de tipo de manutenção.
  ///
  /// Verifica a existência do registro pelo ID para decidir entre
  /// uma operação de INSERT ou UPDATE.
  Future<void> salvar(TipoManutencaoDTO dto) async {
    final db = await Conexao.get();
    // Verifica se o registro já existe para decidir entre inserir ou alterar
    final registroExistente = await consultarPorId(dto.id!);

    if (registroExistente == null) {
      await db.rawInsert(_sqlInsert, [
        dto.id,
        dto.nome,
        dto.descricao,
        dto.ativo ? 1 : 0,
      ]);
    } else {
      await db.rawUpdate(_sqlUpdate, [
        dto.nome,
        dto.descricao,
        dto.ativo ? 1 : 0,
        dto.id,
      ]);
    }
  }

  /// Retorna uma lista de todos os tipos de manutenção cadastrados.
  Future<List<TipoManutencaoDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final List<Map<String, dynamic>> result = await db.rawQuery(_sqlSelectAll);
    return result.map((map) => _fromMap(map)).toList();
  }

  /// Busca um tipo de manutenção específico pelo seu [id].
  ///
  /// Retorna o [TipoManutencaoDTO] se encontrado, caso contrário, retorna `null`.
  Future<TipoManutencaoDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final List<Map<String, dynamic>> result =
        await db.rawQuery(_sqlSelectById, [id]);

    if (result.isNotEmpty) {
      return _fromMap(result.first);
    }
    return null;
  }

  /// Exclui um tipo de manutenção do banco de dados usando o [id].
  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(_sqlDelete, [id]);
  }
}
