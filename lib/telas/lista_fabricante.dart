import 'package:flutter/material.dart';
import 'package:flutter_application_1/banco/dao/dao_fabricante.dart';
import 'package:flutter_application_1/dto/dto_fabricante.dart';

class ListaFabricante extends StatefulWidget {
  const ListaFabricante({super.key});

  @override
  State<ListaFabricante> createState() => _ListaFabricanteState();
}

class _ListaFabricanteState extends State<ListaFabricante> {
  final DAOFabricante _dao = DAOFabricante();
  late Future<List<FabricanteDTO>> _fabricantesFuture;

  @override
  void initState() {
    super.initState();
    _carregarFabricantes();
  }

  void _carregarFabricantes() {
    setState(() {
      _fabricantesFuture = _dao.consultarTodos();
    });
  }

  /// Exibe os detalhes do DTO em um SnackBar.
  void _alterarFabricante(FabricanteDTO fabricante) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alterar: ${fabricante.nome} (ID: ${fabricante.id}) - Contato: ${fabricante.nomeContatoPrincipal}',
        ),
        backgroundColor: Colors.orange[700],
      ),
    );
    // Navegue para o formulário de edição, se houver
    // Navigator.pushNamed(context, '/cadastro_fabricante', arguments: fabricante).then((_) {
    //   _carregarFabricantes();
    // });
  }

  /// Exibe um diálogo de confirmação e, se confirmado, exclui o fabricante.
  void _excluirFabricante(FabricanteDTO fabricante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text('Tem certeza que deseja excluir "${fabricante.nome}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop(); // Fecha o diálogo
                try {
                  await _dao.excluir(fabricante.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Excluído: ${fabricante.nome} (ID: ${fabricante.id})'),
                      backgroundColor: Colors.red[700],
                    ),
                  );
                  _carregarFabricantes(); // Recarrega a lista
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir: $e'),
                      backgroundColor: Colors.red[700],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Fabricantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarFabricantes,
          ),
        ],
      ),
      body: FutureBuilder<List<FabricanteDTO>>(
        future: _fabricantesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhum fabricante cadastrado.'));
          }

          final fabricantes = snapshot.data!;
          return ListView.builder(
            itemCount: fabricantes.length,
            itemBuilder: (context, index) {
              final fabricante = fabricantes[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: ListTile(
                  title: Text(fabricante.nome),
                  subtitle: Text(
                      'Contato: ${fabricante.nomeContatoPrincipal ?? 'N/A'}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _alterarFabricante(fabricante),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _excluirFabricante(fabricante),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro_fabricante').then((_) {
            _carregarFabricantes();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}