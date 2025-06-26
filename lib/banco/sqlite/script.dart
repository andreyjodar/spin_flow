const _tabelas = '''
CREATE TABLE fabricante (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT,
  nome_contato_principal TEXT,
  email_contato TEXT,
  telefone_contato TEXT,
  ativo INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE tipo_manutencao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    ativo INTEGER NOT NULL DEFAULT 1
);
''';

final criarTabelas = [_tabelas];

final insertFabricantes = [
'''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo) 
VALUES ('SpinLife Bikes', 'Fabricante líder em bicicletas de spinning de alta performance e durabilidade.', 'Carlos Andrade', 'contato@spinlife.com.br', '(11) 98765-4321', 1);
''',

'''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo) 
VALUES ('Roda Forte Componentes', 'Especialistas em componentes e peças de reposição como pedais, selins e correias.', 'Beatriz Costa', 'vendas@rodaforte.com', '(21) 91234-5678', 1);
''',

'''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo) 
VALUES ('FitGear Tech', 'Fornecedora de tecnologia para fitness, incluindo monitores cardíacos e sistemas de som.', 'Ricardo Souza', 'ricardo.s@fitgear.tech', '(31) 95555-4444', 1);
''',

'''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo) 
VALUES ('Clean & Cia', 'Empresa especializada em produtos de limpeza e manutenção para equipamentos de ginástica.', 'Juliana Lima', 'suporte@cleanecia.com.br', '(41) 98888-7777', 1);
''',

'''
INSERT INTO fabricante (nome, descricao, nome_contato_principal, email_contato, telefone_contato, ativo) 
VALUES ('Ciclo Total SA', 'Antiga fornecedora de bikes, agora com operações encerradas.', 'Marcos Pereira', 'arquivo@ciclototal.com', '(51) 91111-2222', 0);
'''
];

final insertTiposManutencao = [
'''
INSERT INTO tipo_manutencao (nome, descricao, ativo) 
VALUES ('Limpeza e Lubrificação', 'Limpeza geral da estrutura e lubrificação da corrente, pedais e partes móveis.', 1);
''',

'''
INSERT INTO tipo_manutencao (nome, descricao, ativo) 
VALUES ('Ajuste de Tensão', 'Verificação e ajuste da tensão da correia ou corrente para garantir a resistência correta.', 1);
''',

'''
INSERT INTO tipo_manutencao (nome, descricao, ativo) 
VALUES ('Revisão Eletrônica', 'Checagem do painel digital, sensores de velocidade e monitores cardíacos da bicicleta.', 1);
''',

'''
INSERT INTO tipo_manutencao (nome, descricao, ativo) 
VALUES ('Troca de Peças de Desgaste', 'Substituição de itens com desgaste natural, como selim, pedais e sapatas de freio.', 1);
''',

'''
INSERT INTO tipo_manutencao (nome, descricao, ativo) 
VALUES ('Calibração de Sensores', 'Manutenção obsoleta, substituída pela "Revisão Eletrônica".', 0);
'''
];