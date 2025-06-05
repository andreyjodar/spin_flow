import 'package:flutter/material.dart';

class TelaDashboard extends StatelessWidget {
  const TelaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Visão Geral'),
              Tab(text: 'Cadastros'),
              Tab(text: 'Aulas'),
              Tab(text: 'Manutenção'),
              Tab(text: 'Recados'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _visaoGeral(),
            _cadastros(context),
            _aulasEAuloes(context),
            _manutencao(context),
            _recados(context),
          ],
        ),
      ),
    );
  }

  /// Visão Geral - GridView com 2 colunas e 5 InfoCards
  Widget _visaoGeral() {
    final items = [
      {'icon': Icons.message, 'value': '3', 'title': 'Recados'},
      {'icon': Icons.person, 'value': '82', 'title': 'Alunos Ativos'},
      {'icon': Icons.schedule, 'value': '12', 'title': 'Aulas Agendadas'},
      {'icon': Icons.music_note, 'value': '4', 'title': 'Mix de Músicas'},
      {'icon': Icons.directions_bike, 'value': '18', 'title': 'Bikes OK'},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: items.map((item) {
          return _infoCard(
            icon: item['icon'] as IconData,
            value: item['value'] as String,
            title: item['title'] as String,
          );
        }).toList(),
      ),
    );
  }

  /// Método para criar um InfoCard
  Widget _infoCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  /// Cadastros - ListView com várias opções de cadastro
  Widget _cadastros(BuildContext context) {
    final cadastros = [
      'Vídeo Aula',
      'Aluno',
      'Fabricante',
      'Sala',
      'Tipo Manutenção',
      'Categoria Música',
      'Banda Artista',
      'Turma',
      'Bike',
      'Música',
      'Mix Aula (Playlist)',
      'Grupo Aluno',
    ];

    final Map<String, String> rotasCadastro = {
      'Vídeo Aula': '/cadastro_video_aula',
      'Aluno': '/cadastro_aluno',
      'Fabricante': '/cadastro_fabricante',
      'Sala': '/cadastro_sala',
      'Tipo Manutenção': '/cadastro_tipo_manutencao',
      'Categoria Música': '/cadastro_categoria_musica',
      'Banda Artista': '/cadastro_banda_artista',
      'Turma': '/cadastro_turma',
      'Bike': '/cadastro_bike',
      'Música': '/cadastro_musica',
      'Mix Aula (Playlist)': '/cadastro_mix_aula',
      'Grupo Aluno': '/cadastro_grupo_aluno',
    };

    return ListView.builder(
      itemCount: cadastros.length,
      itemBuilder: (context, index) {
        final titulo = cadastros[index];
        final rota = rotasCadastro[titulo] ?? '';

        return _cadastroTile(
          context: context,
          title: titulo,
          route: rota,
        );
      },
    );
  }

  /// Método para criar um CadastroTile
  Widget _cadastroTile({
    required BuildContext context,
    required String title,
    required String route,
  }) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  /// Aulas e Aulões - Exemplo de seção com ListView e 2 opções
  Widget _aulasEAuloes(BuildContext context) {
    final aulas = ['Gerenciar Aulas', 'Criar Nova Aula'];

    return ListView.builder(
      itemCount: aulas.length,
      itemBuilder: (context, index) {
        return _cadastroTile(
          context: context,
          title: aulas[index],
          route: '', // Rota temporária
        );
      },
    );
  }

  /// Manutenção - Exemplo de seção com ListView e 2 opções
  Widget _manutencao(BuildContext context) {
    final manutencao = ['Registrar Manutenção', 'Histórico de Manutenções'];

    return ListView.builder(
      itemCount: manutencao.length,
      itemBuilder: (context, index) {
        return _cadastroTile(
          context: context,
          title: manutencao[index],
          route: '', // Rota temporária
        );
      },
    );
  }

  /// Recados - Exemplo de seção com ListView e 2 opções
  Widget _recados(BuildContext context) {
    final recados = ['Enviar Recado', 'Visualizar Recados'];

    return ListView.builder(
      itemCount: recados.length,
      itemBuilder: (context, index) {
        return _cadastroTile(
          context: context,
          title: recados[index],
          route: '', // Rota temporária
        );
      },
    );
  }
}
