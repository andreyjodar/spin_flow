import 'package:flutter/material.dart';
import 'package:spin_flow/banco/dao/dao_tipo_manutencao.dart';
import 'package:spin_flow/dto/dto_tipo_manutencao.dart';
import 'package:spin_flow/telas/formularios/form_tipo_manutencao.dart';

class ListaTipoManutencao extends StatefulWidget {
  const ListaTipoManutencao({super.key});

  @override
  State<ListaTipoManutencao> createState() => _ListaTipoManutencaoState();
}

class _ListaTipoManutencaoState extends State<ListaTipoManutencao> {
  final DAOTipoManutencao _dao = DAOTipoManutencao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Manutenção'),
      ),
      body: FutureBuilder<List<TipoManutencaoDTO>>(
        future: _dao.consultarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum tipo de manutenção cadastrado.'));
          } else {
            final tiposManutencao = snapshot.data!;
            return ListView.builder(
              itemCount: tiposManutencao.length,
              itemBuilder: (context, index) {
                final tipoManutencao = tiposManutencao[index];
                return ListTile(
                  title: Text(tipoManutencao.nome),
                  subtitle: Text(tipoManutencao.descricao ?? 'Sem descrição'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Alterar: ${tipoManutencao.nome}')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmarExclusao(context, tipoManutencao);
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormTipoManutencao()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, TipoManutencaoDTO tipoManutencao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text('Tem certeza que deseja excluir "${tipoManutencao.nome}"?'),
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
                _excluirTipoManutencao(tipoManutencao.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _excluirTipoManutencao(int id) async {
    await _dao.excluir(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tipo de manutenção excluído com sucesso!')),
    );
    setState(() {});
  }
}