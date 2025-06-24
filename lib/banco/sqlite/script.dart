const tabelas = '''
CREATE TABLE abricante (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT,
  nomeContatoPrincipal TEXT,
  emailContato TEXT,
  telefoneContato TEXT,
  ativo INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE tipo_manutencao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT
    ativo INTEGER NOT NULL DEFAULT 1
);
''';

final criarTabelas = [tabelas];

final insertFabricantes = [
  '''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
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

INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
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
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
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
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
VALUES (
  'Echelon',
  'Concorrente da Peloton, com bicicletas conectadas e uma vasta biblioteca de aulas.',
  'Mariana Lima',
  'info@echelonfit.com',
  '(41) 96543-2109',
  1
);

''',
  '''
INSERT INTO Fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo)
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

final insertTiposManutencao = [
  '''
  INSERT INTO tipo_manutencao (nome, descricao) VALUES ('Limpeza e Verificação Geral', 'Limpeza da estrutura, verificação de ruídos e estabilidade da bicicleta.');
  INSERT INTO tipo_manutencao (nome, descricao) VALUES ('Ajuste de Freio e Resistência', 'Verificação e ajuste da sapata de freio ou sistema de resistência magnética.');
  INSERT INTO tipo_manutencao (nome, descricao) VALUES ('Lubrificação da Transmissão', 'Aplicação de lubrificante específico na corrente ou correia de transmissão.');
  INSERT INTO tipo_manutencao (nome, descricao) VALUES ('Reaperto de Componentes', 'Checagem e reaperto dos parafusos do selim, guidão, pedais e pé de vela.');
  INSERT INTO tipo_manutencao (nome, descricao) VALUES ('Checagem do Painel Eletrônico', 'Verificação das baterias, funcionamento do display e sensores de cadência/velocidade.');
  '''
];
