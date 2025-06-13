import 'package:flutter/material.dart';
import 'package:flutter_application_1/banco/dao/dao_sala.dart'; // 1. IMPORTE SEU DAO
import 'package:flutter_application_1/dto/dto_sala.dart'; // Importe seu DTO

class ListaSala extends StatefulWidget {
  const ListaSala({super.key});

  @override
  State<ListaSala> createState() => _ListaSalaState();
}

class _ListaSalaState extends State<ListaSala> {
  // 2. DEFINA O DAO
  final DAOSala dao = DAOSala();

  // Variável para guardar o Future da consulta
  late Future<List<SalaDTO>> _salasFuture;

  @override
  void initState() {
    super.initState();
    // Inicia a busca pelos dados uma única vez
    _salasFuture = dao.consultarTodos();
  }

  // A lógica de exclusão agora precisa atualizar a tela
  void _excluirSala(String salaId) async {
    // Mostra um diálogo de confirmação
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Você tem certeza que deseja excluir esta sala?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmou ?? false) {
      await dao.excluir(salaId);
      // Atualiza o estado para reconstruir a lista com os dados novos
      setState(() {
        _salasFuture = dao.consultarTodos();
      });
    }
  }

  // A lógica para alterar será parecida (navegar e depois atualizar)
  void _alterarSala(SalaDTO sala) {
    print('--- DADOS DA SALA PARA ALTERAÇÃO ---');
    print(sala);
    // FUTURAMENTE:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioSala(sala: sala)))
    //     .then((_) => setState(() {
    //           _salasFuture = dao.consultarTodos();
    //         }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salas de Spinning (BD)'),
        backgroundColor: Colors.deepPurple,
      ),
      // 3. SUBSTITUA O BODY PELO FUTUREBUILDER
      body: FutureBuilder<List<SalaDTO>>(
        future: _salasFuture, // O Future que o builder vai "escutar"
        builder: (context, snapshot) {
          // CASO 1: AINDA CARREGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // CASO 2: OCORREU UM ERRO
          if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar as salas: ${snapshot.error}'));
          }

          // CASO 3: DADOS VAZIOS
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhuma sala encontrada no banco de dados.'));
          }

          // CASO 4: SUCESSO! DADOS CARREGADOS
          final salas = snapshot.data!;
          return ListView.builder(
            itemCount: salas.length,
            itemBuilder: (context, index) {
              final sala = salas[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        sala.ativo ? Colors.deepPurple : Colors.grey,
                    child:
                        const Icon(Icons.directions_bike, color: Colors.white),
                  ),
                  title: Text(sala.nome),
                  subtitle: Text(
                    'Capacidade: ${sala.capacidadeTotalBikes} bikes (${sala.numeroFilas}x${sala.numeroBikesPorFila})',
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            _alterarSala(sala);
                          },
                          tooltip: 'Alterar Sala',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // O id da sala nunca será nulo aqui
                            _excluirSala(sala.id!);
                          },
                          tooltip: 'Excluir Sala',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
