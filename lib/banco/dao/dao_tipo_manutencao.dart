import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/dto_tipo_manutencao.dart';

class DAOTipoManutencao {
  final String _tabela = 'tipo_manutencao';
  final String _sqlSelectAll = 'SELECT * FROM tipo_manutencao ORDER BY nome';
  final String _sqlSelectById = 'SELECT * FROM tipo_manutencao WHERE id = ?';

  Future<TipoManutencaoDTO> salvar(TipoManutencaoDTO tipoManutencao) async {
    final db = await Conexao.get();
    final map = _toMap(tipoManutencao);

    if (tipoManutencao.id == null) {
      final id = await db.insert(_tabela, map);
      return TipoManutencaoDTO(
        id: id,
        nome: tipoManutencao.nome,
        descricao: tipoManutencao.descricao,
        ativo: tipoManutencao.ativo,
      );
    } else {
      await db.update(
        _tabela,
        map,
        where: 'id = ?',
        whereArgs: [tipoManutencao.id],
      );
      return tipoManutencao;
    }
  }

  Future<TipoManutencaoDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final List<Map<String, dynamic>> maps = await db.rawQuery(_sqlSelectById, [id]);

    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TipoManutencaoDTO>> consultarTodos() async {
    final db = await Conexao.get();
    final List<Map<String, dynamic>> maps = await db.rawQuery(_sqlSelectAll);

    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

  Future<int> excluir(int id) async {
    final db = await Conexao.get();
    return await db.delete(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(TipoManutencaoDTO tipoManutencao) {
    return {
      'id': tipoManutencao.id,
      'nome': tipoManutencao.nome,
      'descricao': tipoManutencao.descricao,
      'ativo': tipoManutencao.ativo ? 1 : 0,
    };
  }

  TipoManutencaoDTO _fromMap(Map<String, dynamic> map) {
    return TipoManutencaoDTO(
      id: map['id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String?,
      ativo: (map['ativo'] as int) == 1,
    );
  }
}
