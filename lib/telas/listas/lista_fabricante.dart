import 'package:flutter/material.dart';
import 'package:spin_flow/banco/dao/dao_fabricante.dart'; // Ajuste o caminho para seu DAO
import 'package:spin_flow/dto/dto_fabricante.dart';       // Ajuste o caminho para seu DTO

class ListaFabricante extends StatefulWidget {
  const ListaFabricante({super.key});

  @override
  State<ListaFabricante> createState() => _ListaFabricanteState();
}

class _ListaFabricanteState extends State<ListaFabricante> {
  final DAOFabricante _dao = DAOFabricante();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Fabricantes'),
      ),
      body: FutureBuilder<List<FabricanteDTO>>(
        future: _dao.consultarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar fabricantes: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum fabricante cadastrado.'));
          } else {
            final fabricantes = snapshot.data!;
            return ListView.builder(
              itemCount: fabricantes.length,
              itemBuilder: (context, index) {
                final fabricante = fabricantes[index];
                return ListTile(
                  title: Text(fabricante.nome),
                  subtitle: Text(fabricante.emailContato ?? 'Sem email de contato'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Alterar: ${fabricante.nome}')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmarExclusao(context, fabricante);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/form_fabricante');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, FabricanteDTO fabricante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text('Tem certeza que deseja excluir o fabricante "${fabricante.nome}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _excluirFabricante(fabricante.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _excluirFabricante(int id) async {
    await _dao.excluir(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fabricante excluído com sucesso!')),
    );
    setState(() {});
  }
}