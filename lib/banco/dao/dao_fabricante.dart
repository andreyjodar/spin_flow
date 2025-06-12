import 'package:flutter_application_1/banco/sqlite/conexao.dart';
import 'package:flutter_application_1/dto/dto_fabricante..dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/banco/sqlite/conexao.dart'; // Assumindo que Conexao está neste caminho

class DAOFabricante {
  final String _tableName = 'Fabricante';
  final String _sqlInsert = '''
    INSERT INTO Fabricante (
      nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo
    ) VALUES (?, ?, ?, ?, ?, ?)
  ''';
  final String _sqlUpdate = '''
    UPDATE Fabricante SET
      nome = ?, descricao = ?, nome_contato_principal = ?, email_contato = ?, telefone_contato = ?, ativo = ?
    WHERE id = ?
  ''';
  final String _sqlSelectAll = 'SELECT * FROM Fabricante';
  final String _sqlSelectById = 'SELECT * FROM Fabricante WHERE id = ?';
  final String _sqlDelete = 'DELETE FROM Fabricante WHERE id = ?';

  // Converte um Map (do banco de dados) para um DTOFabricante
  FabricanteDTO _fromMap(Map<String, dynamic> map) {
    return FabricanteDTO(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String?,
      nomeContatoPrincipal: map['nome_contato_principal'] as String?,
      emailContato: map['email_contato'] as String?,
      telefoneContato: map['telefone_contato'] as String?,
      ativo: map['ativo'] == 1, // Converte INTEGER (1/0) para bool
    );
  }

  // Converte um DTOFabricante para um Map (para o banco de dados)
  Map<String, dynamic> _toMap(FabricanteDTO dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'descricao': dto.descricao,
      'nome_contato_principal': dto.nomeContatoPrincipal,
      'email_contato': dto.emailContato,
      'telefone_contato': dto.telefoneContato,
      'ativo': dto.ativo ? 1 : 0, // Converte bool para INTEGER (1/0)
    };
  }

  Future<int> salvar(FabricanteDTO dto) async {
    final db = await Conexao.get();
    int id;

    if (dto.id == null) {
      // Inserir novo registro
      try {
        id = await db.rawInsert(_sqlInsert, [
          dto.nome,
          dto.descricao,
          dto.nomeContatoPrincipal,
          dto.emailContato,
          dto.telefoneContato,
          dto.ativo ? 1 : 0,
        ]);
      } catch (e) {
        print('Erro ao inserir Fabricante: $e');
        rethrow;
      }
    } else {
      // Alterar registro existente
      try {
        id = await db.rawUpdate(_sqlUpdate, [
          dto.nome,
          dto.descricao,
          dto.nomeContatoPrincipal,
          dto.emailContato,
          dto.telefoneContato,
          dto.ativo ? 1 : 0,
          dto.id,
        ]);
      } catch (e) {
        print('Erro ao alterar Fabricante: $e');
        rethrow;
      }
    }
    return id; // Retorna o ID do registro inserido ou o número de linhas atualizadas
  }

  Future<List<FabricanteDTO>> consultarTodos() async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery(_sqlSelectAll);
      return List.generate(maps.length, (i) {
        return _fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao consultar todos os Fabricantes: $e');
      rethrow;
    }
  }

  Future<FabricanteDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    try {
      final List<Map<String, dynamic>> maps =
          await db.rawQuery(_sqlSelectById, [id]);
      if (maps.isNotEmpty) {
        return _fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Erro ao consultar Fabricante por ID: $e');
      rethrow;
    }
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    try {
      return await db.rawDelete(_sqlDelete, [id]);
    } catch (e) {
      print('Erro ao excluir Fabricante: $e');
      rethrow;
    }
  }
}
