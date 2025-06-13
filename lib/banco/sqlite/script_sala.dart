final _sala = '''

CREATE TABLE sala (
    id TEXT PRIMARY KEY,
    nome TEXT NOT NULL UNIQUE,
    capacidade_total_bikes INTEGER NOT NULL,
    numero_filas INTEGER NOT NULL,
    numero_bikes_por_fila INTEGER NOT NULL,
    ativo INTEGER NOT NULL
)

''';

final criarTabelas = [_sala];

final inserirSalas = [
  '''
INSERT INTO sala (id, nome, capacidade_total_bikes, numero_filas, numero_bikes_por_fila, ativo) 
VALUES 
('sala-id-01', 'Sala Power', 20, 4, 5, 1)
''',
  '''
INSERT INTO sala (id, nome, capacidade_total_bikes, numero_filas, numero_bikes_por_fila, ativo) 
VALUES 
('sala-id-02', 'Sala Zen', 12, 3, 4, 1)
''',
  '''
INSERT INTO sala (id, nome, capacidade_total_bikes, numero_filas, numero_bikes_por_fila, ativo) 
VALUES 
('sala-id-03', 'Sala Cardio Max', 25, 5, 5, 1)
''',
  '''
INSERT INTO sala (id, nome, capacidade_total_bikes, numero_filas, numero_bikes_por_fila, ativo) 
VALUES 
('sala-id-04', 'Sala Manutenção', 10, 2, 5, 0)
''',
];
