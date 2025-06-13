// Mock de lista de alunos de spinning (antes da classe do widget)
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/dto_aluno.dart';

List<AlunoDTO> mockAlunosSpinning = [
  AlunoDTO(
    id: 1,
    nome: 'Beatriz Almeida',
    email: 'bia.almeida@email.com',
    dataNascimento: DateTime(1993, 7, 21),
    genero: 'Feminino',
    telefoneContato: '(11) 98765-1234',
    perfilInstagram: '@bia_spinning_queen',
    perfilFacebook: 'Beatriz Almeida Spin',
    ativo: true,
  ),
  AlunoDTO(
    id: 2,
    nome: 'Gustavo Santos',
    email: 'guga.santos@email.com',
    dataNascimento: DateTime(1989, 11, 3),
    genero: 'Masculino',
    telefoneContato: '(21) 99876-5432',
    perfilTiktok: '@gugaspin',
    ativo: true,
  ),
  AlunoDTO(
    id: 3,
    nome: 'Camila Ribeiro',
    email: 'camilinha@email.com',
    dataNascimento: DateTime(1996, 2, 14),
    genero: 'Feminino',
    telefoneContato: '(31) 97654-3210',
    perfilInstagram: '@camilaspinfit',
    perfilFacebook: 'Camila Ribeiro Spinning',
    perfilTiktok: '@camilinhaspin',
    ativo: false, // Aluno inativo
  ),
  AlunoDTO(
    id: 4,
    nome: 'Felipe Martins',
    email: 'felipe.m@email.com',
    dataNascimento: DateTime(1987, 9, 25),
    genero: 'Masculino',
    telefoneContato: '(41) 91234-5678',
    ativo: true, // Sem perfis de redes sociais
  ),
  AlunoDTO(
    id: 5,
    nome: 'Larissa Guedes',
    email: 'lari.guedes@email.com',
    dataNascimento: DateTime(1991, 4, 1),
    genero: 'Feminino',
    telefoneContato: '(51) 92345-6789',
    perfilInstagram: '@larissaguedes_spin',
    ativo: true,
  ),
];

class ListaAluno extends StatefulWidget {
  const ListaAluno({super.key});

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  // Simula uma chamada assíncrona ao banco de dados
  Future<List<AlunoDTO>> _fetchAlunos() async {
    // Adiciona um pequeno atraso para simular o carregamento de dados
    await Future.delayed(const Duration(seconds: 2));
    return mockAlunosSpinning;
  }

  void _alterarAluno(BuildContext context, AlunoDTO aluno) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Método Alterar chamado para:\n${aluno.toString()}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
        duration: const Duration(seconds: 4),
      ),
    );
    // Futuramente, aqui você chamaria uma tela de edição ou um método de atualização do banco de dados
  }

  void _excluirAluno(BuildContext context, AlunoDTO aluno) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Método Excluir chamado para:\n${aluno.toString()}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 4),
      ),
    );
    // Futuramente, aqui você chamaria um método de exclusão do banco de dados
    // e atualizaria a lista de alunos após a exclusão bem-sucedida.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos de Spinning'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<AlunoDTO>>(
        future: _fetchAlunos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar alunos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum aluno encontrado.'));
          } else {
            // Se houver dados, exiba a lista
            final List<AlunoDTO> alunos = snapshot.data!;
            return ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(aluno.email),
                        Text('Telefone: ${aluno.telefoneContato}'),
                        Text('Ativo: ${aluno.ativo ? 'Sim' : 'Não'}'),
                        if (aluno.perfilInstagram != null &&
                            aluno.perfilInstagram!.isNotEmpty)
                          Text('IG: ${aluno.perfilInstagram}'),
                        if (aluno.perfilFacebook != null &&
                            aluno.perfilFacebook!.isNotEmpty)
                          Text('FB: ${aluno.perfilFacebook}'),
                        if (aluno.perfilTiktok != null &&
                            aluno.perfilTiktok!.isNotEmpty)
                          Text('TT: ${aluno.perfilTiktok}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _alterarAluno(context, aluno),
                          tooltip: 'Alterar Aluno',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _excluirAluno(context, aluno),
                          tooltip: 'Excluir Aluno',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
