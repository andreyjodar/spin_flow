import 'package:spin_flow/banco/sqlite/conexao.dart';
import 'package:spin_flow/dto/dto_fabricante.dart';

class DAOFabricante {
  final String _tabela = 'fabricante';
  final String _sqlSelectAll = 'SELECT * FROM fabricante ORDER BY nome';
  final String _sqlSelectById = 'SELECT * FROM fabricante WHERE id = ?';

  Future<FabricanteDTO> salvar(FabricanteDTO fabricante) async {
    final db = await Conexao.get();
    final map = _toMap(fabricante);

    if (fabricante.id == null) {
      final id = await db.insert(_tabela, map);
      return FabricanteDTO(
        id: id,
        nome: fabricante.nome,
        descricao: fabricante.descricao,
        nomeContatoPrincipal: fabricante.nomeContatoPrincipal,
        emailContato: fabricante.emailContato,
        telefoneContato: fabricante.telefoneContato,
        ativo: fabricante.ativo,
      );
    } else {
      await db.update(
        _tabela,
        map,
        where: 'id = ?',
        whereArgs: [fabricante.id],
      );
      return fabricante;
    }
  }

  Future<FabricanteDTO?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final List<Map<String, dynamic>> maps = await db.rawQuery(_sqlSelectById, [id]);

    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<FabricanteDTO>> consultarTodos() async {
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

  Map<String, dynamic> _toMap(FabricanteDTO fabricante) {
    return {
      'id': fabricante.id,
      'nome': fabricante.nome,
      'descricao': fabricante.descricao,
      'nome_contato_principal': fabricante.nomeContatoPrincipal,
      'email_contato': fabricante.emailContato,
      'telefone_contato': fabricante.telefoneContato,
      'ativo': fabricante.ativo ? 1 : 0,
    };
  }

  FabricanteDTO _fromMap(Map<String, dynamic> map) {
    return FabricanteDTO(
      id: map['id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String?,
      nomeContatoPrincipal: map['nome_contato_principal'] as String?,
      emailContato: map['email_contato'] as String?,
      telefoneContato: map['telefone_contato'] as String?,
      ativo: (map['ativo'] as int) == 1,
    );
  }
}
