import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/dto_tipo_manutencao.dart';
import 'package:flutter_application_1/banco/dao/dao_tipo_manutencao.dart';

class ListaTipoManutencao extends StatefulWidget {
  const ListaTipoManutencao({super.key});

  @override
  State<ListaTipoManutencao> createState() => _ListaTipoManutencaoState();
}

class _ListaTipoManutencaoState extends State<ListaTipoManutencao> {
  final DAOTipoManutencao _dao = DAOTipoManutencao();

  // Função para confirmar a exclusão de um item
  void _confirmarExclusao(
      BuildContext context, TipoManutencaoDTO tipoManutencao) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
              'Você tem certeza que deseja excluir "${tipoManutencao.nome}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _excluirTipoManutencao(tipoManutencao);
                Navigator.of(ctx).pop(); // Fecha o diálogo
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Função para excluir e atualizar a tela
  void _excluirTipoManutencao(TipoManutencaoDTO tipoManutencao) async {
    if (tipoManutencao.id != null) {
      await _dao.excluir(tipoManutencao.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Tipo de manutenção "${tipoManutencao.nome}" excluído com sucesso!')),
      );
      // Atualiza a interface para refletir a exclusão
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tipos de Manutenção'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<TipoManutencaoDTO>>(
        future: _dao.consultarTodos(),
        builder: (context, snapshot) {
          // Enquanto os dados estão carregando, exibe um indicador de progresso
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Se ocorrer um erro na busca dos dados
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          // Se os dados forem carregados com sucesso
          if (snapshot.hasData) {
            final List<TipoManutencaoDTO> listaTiposManutencao = snapshot.data!;

            if (listaTiposManutencao.isEmpty) {
              return const Center(
                  child: Text('Nenhum tipo de manutenção cadastrado.'));
            }

            return ListView.builder(
              itemCount: listaTiposManutencao.length,
              itemBuilder: (context, index) {
                final TipoManutencaoDTO tipoManutencao =
                    listaTiposManutencao[index];
                return ListTile(
                  title: Text(tipoManutencao.nome),
                  subtitle: Text(tipoManutencao.descricao ?? 'Sem descrição'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ícone de Alterar
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          // TODO: Implementar a navegação para a tela de edição
                          // Navigator.pushNamed(context, '/cadastro_tipo_manutencao', arguments: tipoManutencao);
                        },
                      ),
                      // Ícone de Excluir
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

          // Estado padrão (não deve ser alcançado em um cenário normal)
          return const Center(child: Text('Aguardando dados...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro_tipo_manutencao').then((_) {
            // Atualiza a lista quando retorna da tela de cadastro
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}