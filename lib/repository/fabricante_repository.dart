import 'package:flutter_application_1/dto/dto_fabricante..dart';

class FabricanteRepository {
  final List<FabricanteDTO> _fabricantes = [
    FabricanteDTO(
        nome: 'teste',
        descricao: 'descricao',
        nomeContatoPrincipal: 'testado',
        emailContato: 'teste@email.com',
        telefoneContato: '77740-38737',
        ativo: true),
  ];

  /// Adiciona um novo Fabricante
  void adicionar(FabricanteDTO fabricante) {
    _fabricantes.add(fabricante);
  }

  /// Retorna todos os Fabricantes
  List<FabricanteDTO> listarTodos() {
    return List.unmodifiable(_fabricantes);
  }

  /// Busca um Fabricante pelo ID
  FabricanteDTO? buscarPorId(String id) {
    try {
      return _fabricantes.firstWhere((fab) => fab.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Atualiza um Fabricante existente
  void atualizar(FabricanteDTO fabricanteAtualizado) {
    final index =
        _fabricantes.indexWhere((fab) => fab.id == fabricanteAtualizado.id);
    if (index != -1) {
      _fabricantes[index] = fabricanteAtualizado;
    }
  }

  /// Remove um Fabricante pelo ID
  void remover(String id) {
    return _fabricantes.removeWhere((fab) => fab.id == id);
  }
}
