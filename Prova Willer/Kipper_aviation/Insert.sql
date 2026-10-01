INSERT INTO aeronaves (modelo, codigo_cauda, capacidade) VALUES
('boing67', 'ABC-670', 67),
('boinggrande', 'BBC-777', 180),
('boingmedio', 'ABC-333', 100),
('boingcuticuti', 'ABC-111', 20),
('boingdaprogasto', 'ABC-690', 130);

INSERT INTO pilotos (nome, codigo_anac, horas_voo) VALUES
('Sergio', 'ABCDRF', 91),
('Adalto', 'ASCDRF', 0),
('Sofia', 'ABCDKF', 999),
('Francisco', 'WBCDRF', 92),
('Kipper', 'ABCDRP', 101);

INSERT INTO passageiros (nome, cpf, email) VALUES
('passageiro1', '11133344451', 'passageiro1@kipper.com'),
('passageiro2', '11133344452', 'passageiro2@kipper.com'),
('passageiro3', '11133344453', 'passageiro3@kipper.com'),
('passageiro4', '11133344454', 'passageiro4@kipper.com'),
('passageiro5', '11133344455', 'passageiro5@kipper.com');

INSERT INTO voos (aeronave_id, piloto_id, numero_voo, origem, destino, status) VALUES
(1, 1, '123', 'sapucaia','pernambuco','Agendado'),
(2, 2, '133', 'pernambuco','saopaulo','Em Voo'),
(3, 3, '143', 'saopaulo','santacatarina','Concluido'),
(4, 4, '153', 'santacatarina','florianopolis','Cancelado'),
(5, 5, '163', 'florianopolis','sla','Agendado');

INSERT INTO passagens (voo_id, passageiro_id, assento, classe, valor) VALUES
(1, 1, 'A1','Economica',300.00),
(1, 2, 'A2','Economica',300.00),
(1, 3, 'A3','Economica',300.00),
(1, 4, 'A4', 'Executiva',900.00),
(1, 5, 'A5','Executiva',900.00);