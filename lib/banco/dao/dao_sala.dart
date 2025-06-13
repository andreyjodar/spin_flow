import 'package:flutter_application_1/banco/sqlite/conexao.dart'; // Corrija o caminho se necessário
import 'package:flutter_application_1/dto/dto_sala.dart'; // Corrija o caminho se necessário
import 'package:sqflite/sqflite.dart';

class DAOSala {
  final String _tableName = 'sala';
  final String _sqlInsert = '''
    INSERT INTO sala (
      id, nome, capacidade_total_bikes, numero_filas, numero_bikes_por_fila, ativo
    ) VALUES (?, ?, ?, ?, ?, ?)
  ''';
  final String _sqlUpdate = '''
    UPDATE sala SET
      nome = ?, capacidade_total_bikes = ?, numero_filas = ?, numero_bikes_por_fila = ?, ativo = ?
    WHERE id = ?
  ''';
  final String _sqlSelectAll = 'SELECT * FROM sala';
  final String _sqlSelectById = 'SELECT * FROM sala WHERE id = ?';
  final String _sqlDelete = 'DELETE FROM sala WHERE id = ?';

  // Converte um Map (do banco de dados) para um SalaDTO
  SalaDTO _fromMap(Map<String, dynamic> map) {
    return SalaDTO(
      id: map['id'] as String?,
      nome: map['nome'] as String,
      capacidadeTotalBikes: map['capacidade_total_bikes'] as int,
      numeroFilas: map['numero_filas'] as int,
      numeroBikesPorFila: map['numero_bikes_por_fila'] as int,
      ativo: map['ativo'] == 1,
    );
  }

  // Este método não é usado diretamente pelos métodos raw, mas mantido para consistência
  Map<String, dynamic> _toMap(SalaDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'capacidade_total_bikes': dto.capacidadeTotalBikes,
      'numero_filas': dto.numeroFilas,
      'numero_bikes_por_fila': dto.numeroBikesPorFila,
      'ativo': dto.ativo ? 1 : 0,
    };
  }

  Future<int> salvar(SalaDTO dto) async {
    final db = await Conexao.get();

    // Como o ID da Sala (UUID) é sempre gerado no DTO,
    // precisamos verificar se o registro já existe para decidir entre INSERT e UPDATE.
    final registroExistente = await consultarPorId(dto.id!);

    if (registroExistente == null) {
      // Inserir novo registro
      try {
        // rawInsert retorna o 'rowid' interno do SQLite, que é um int.
        return await db.rawInsert(_sqlInsert, [
          dto.id,
          dto.nome,
          dto.capacidadeTotalBikes,
          dto.numeroFilas,
          dto.numeroBikesPorFila,
          dto.ativo ? 1 : 0,
        ]);
      } catch (e) {
        print('Erro ao inserir Sala: $e');
        rethrow;
      }
    } else {
      // Alterar registro existente
      try {
        // rawUpdate retorna o número de linhas afetadas, que é um int.
        return await db.rawUpdate(_sqlUpdate, [
          dto.nome,
          dto.capacidadeTotalBikes,
          dto.numeroFilas,
          dto.numeroBikesPorFila,
          dto.ativo ? 1 : 0,
          dto.id,
        ]);
      } catch (e) {
        print('Erro ao alterar Sala: $e');
        rethrow;
      }
    }
  }

  Future<List<SalaDTO>> consultarTodos() async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery(_sqlSelectAll);
      return List.generate(maps.length, (i) {
        return _fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao consultar todas as Salas: $e');
      rethrow;
    }
  }

  Future<SalaDTO?> consultarPorId(String id) async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> maps =
          await db.rawQuery(_sqlSelectById, [id]);
      if (maps.isNotEmpty) {
        return _fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Erro ao consultar Sala por ID: $e');
      rethrow;
    }
  }

  Future<int> excluir(String id) async {
    final db = await Conexao.get();
    try {
      return await db.rawDelete(_sqlDelete, [id]);
    } catch (e) {
      print('Erro ao excluir Sala: $e');
      rethrow;
    }
  }
}
