final _fabricante = '''
CREATE TABLE fabricante (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT,
  nomeContatoPrincipal TEXT,
  emailContato TEXT,
  telefoneContato TEXT,
  ativo INTEGER NOT NULL DEFAULT 1
)
''';

final _aluno = '''
CREATE TABLE alunos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  email TEXT NOT NULL,
  dataNascimento TEXT NOT NULL,
  genero TEXT NOT NULL,
  telefoneContato TEXT NOT NULL,
  perfilInstagram TEXT,
  perfilFacebook TEXT,
  perfilTiktok TEXT,
  ativo INTEGER NOT NULL
)
''';

final criarTabelas = [_fabricante, _aluno];

final insertFabricantes = [
  '''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Peloton',
  'Líder em bicicletas de spinning interativas com aulas online.',
  'Alexandre Costa',
  'contato@onepeloton.com',
  '(21) 98765-4321',
  1
)
''',
  '''

INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'NordicTrack',
  'Fabricante de equipamentos de fitness com integração iFit.',
  'Beatriz Souza',
  'suporte@nordictrack.com',
  '(11) 99876-5432',
  1
)

''',
  '''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Stryde',
  'Bicicletas de spinning inteligentes com experiência de treino personalizável.',
  'Carlos Pereira',
  'vendas@strydebike.com',
  '(31) 97654-3210',
  1
)

''',
  '''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Echelon',
  'Concorrente da Peloton, com bicicletas conectadas e uma vasta biblioteca de aulas.',
  'Mariana Lima',
  'info@echelonfit.com',
  '(41) 96543-2109',
  1
)

''',
  '''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Sole Fitness',
  'Equipamentos de fitness para uso doméstico, conhecidos pela durabilidade.',
  'Roberto Mendes',
  'atendimento@solefitness.com',
  '(51) 95432-1098',
  0
)

'''
];

final inserirAlunos = [
  '''
INSERT INTO alunos (nome, email, dataNascimento, genero, telefoneContato, perfilInstagram, perfilFacebook, perfilTiktok, ativo) 
VALUES (
  'Sofia Moraes', 
  'sofia.moraes@email.com', 
  '1994-08-12T00:00:00.000Z', 
  'Feminino', 
  '(11) 98765-4321', 
  '@sofiaspinning', 
  'Sofia Moraes Cycling', 
  '', 
  1
)
''',
  '''
INSERT INTO alunos (nome, email, dataNascimento, genero, telefoneContato, perfilInstagram, perfilFacebook, perfilTiktok, ativo) 
VALUES (
  'Ricardo Neves', 
  'ricardo.neves@email.com', 
  '1987-04-25T00:00:00.000Z', 
  'Masculino', 
  '(21) 99123-4567', 
  '', 
  'Ricardo Neves Treinos', 
  '@ricardotiktokfit', 
  1
)
''',
  '''
INSERT INTO alunos (nome, email, dataNascimento, genero, telefoneContato, perfilInstagram, perfilFacebook, perfilTiktok, ativo) 
VALUES (
  'Patrícia Santos', 
  'paty.santos@email.com', 
  '1999-01-01T00:00:00.000Z', 
  'Feminino', 
  '(31) 97654-3210', 
  '@patyspin_oficial', 
  '', 
  '', 
  0
)
''',
  '''
INSERT INTO alunos (nome, email, dataNascimento, genero, telefoneContato, perfilInstagram, perfilFacebook, perfilTiktok, ativo) 
VALUES (
  'Eduardo Costa', 
  'edu.costa@email.com', 
  '1990-10-10T00:00:00.000Z', 
  'Masculino', 
  '(41) 99999-8888', 
  '@eduspinfit', 
  'Eduardo Costa - Spinning', 
  '@educostafit', 
  1
)
''',
  '''
INSERT INTO alunos (nome, email, dataNascimento, genero, telefoneContato, perfilInstagram, perfilFacebook, perfilTiktok, ativo) 
VALUES (
  'Fernanda Lima', 
  'fe.lima@email.com', 
  '1995-06-30T00:00:00.000Z', 
  'Feminino', '(51) 98123-4567', 
  '@fernandaindoorbike', 
  'Fernanda Lima Personal', 
  '', 
  1
)
'''
];
