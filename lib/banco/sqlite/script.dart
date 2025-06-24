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