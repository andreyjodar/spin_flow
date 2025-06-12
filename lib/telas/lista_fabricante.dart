import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/dto_fabricante..dart';
import 'package:uuid/uuid.dart';

// Mock de lista de dados de Fabricante
List<FabricanteDTO> mockFabricantesSpinning = [
  FabricanteDTO(
    nome: 'Shimano Components',
    descricao: 'Fabricante de componentes de spinning de alta performance.',
    nomeContatoPrincipal: 'Kenji Tanaka',
    emailContato: 'kenji.tanaka@shimano.com',
    telefoneContato: '+81-3-1234-5678',
    ativo: true,
  ),
  FabricanteDTO(
    nome: 'Daiwa Fishing',
    descricao: 'Fabricante líder de equipamentos de pesca para spinning.',
    nomeContatoPrincipal: 'Takeshi Yamada',
    emailContato: 'takeshi.yamada@daiwa.com',
    telefoneContato: '+81-3-8765-4321',
    ativo: true,
  ),
  FabricanteDTO(
    nome: 'Penn Fishing Tackle',
    descricao: 'Especialista em equipamentos de pesca robustos para spinning.',
    nomeContatoPrincipal: 'Robert Johnson',
    emailContato: 'robert.johnson@pennfishing.com',
    telefoneContato: '+1-215-987-6543',
    ativo: true,
  ),
  FabricanteDTO(
    nome: 'Abu Garcia',
    descricao: 'Fabricante sueco de carretilhas e varas de spinning.',
    nomeContatoPrincipal: 'Johan Svensson',
    emailContato: 'johan.svensson@abugarcia.com',
    telefoneContato: '+46-8-1122-3344',
    ativo: false,
  ),
  FabricanteDTO(
    nome: 'Okuma Fishing Tackle',
    descricao:
        'Inovador em equipamentos de pesca de água salgada para spinning.',
    nomeContatoPrincipal: 'David Lee',
    emailContato: 'david.lee@okuma.com',
    telefoneContato: '+886-4-5678-9012',
    ativo: true,
  ),
];

// Widget para listar Fabricantes
class ListaFabricante extends StatefulWidget {
  const ListaFabricante({super.key});

  @override
  State<ListaFabricante> createState() => _ListaFabricanteState();
}

class _ListaFabricanteState extends State<ListaFabricante> {
  List<FabricanteDTO> fabricantes = mockFabricantesSpinning;

  // Função para excluir um Fabricante
  void _excluirFabricante(FabricanteDTO fabricante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tem certeza que deseja excluir este fabricante?'),
              const SizedBox(height: 10),
              Text('Nome: ${fabricante.nome}'),
              Text('Descrição: ${fabricante.descricao}'),
              Text('Contato: ${fabricante.nomeContatoPrincipal}'),
              Text('Email: ${fabricante.emailContato}'),
              Text('Telefone: ${fabricante.telefoneContato}'),
              Text('Ativo: ${fabricante.ativo ? 'Sim' : 'Não'}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                setState(() {
                  fabricantes.removeWhere((f) => f.id == fabricante.id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Fabricante "${fabricante.nome}" excluído com sucesso!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Função para alterar um Fabricante (apenas simula a exibição do DTO)
  void _alterarFabricante(FabricanteDTO fabricante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterar Fabricante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Você está prestes a alterar este fabricante:'),
              const SizedBox(height: 10),
              Text('ID: ${fabricante.id}'),
              Text('Nome: ${fabricante.nome}'),
              Text('Descrição: ${fabricante.descricao}'),
              Text(
                  'Nome Contato Principal: ${fabricante.nomeContatoPrincipal}'),
              Text('Email Contato: ${fabricante.emailContato}'),
              Text('Telefone Contato: ${fabricante.telefoneContato}'),
              Text('Ativo: ${fabricante.ativo ? 'Sim' : 'Não'}'),
              const SizedBox(height: 10),
              const Text(
                  'Aqui você implementaria a navegação para uma tela de edição ou um formulário de alteração.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: const Text('Lista de Fabricantes (Spinning)'),
      ),
      body: ListView.builder(
        itemCount: fabricantes.length,
        itemBuilder: (context, index) {
          final fabricante = fabricantes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fabricante.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fabricante.descricao!,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Contato: ${fabricante.nomeContatoPrincipal}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Email: ${fabricante.emailContato}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Telefone: ${fabricante.telefoneContato}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Ativo: ${fabricante.ativo ? 'Sim' : 'Não'}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Para rodar este exemplo, você pode usar a seguinte estrutura em sua função main:
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Fabricantes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListaFabricante(),
    );
  }
}
*/