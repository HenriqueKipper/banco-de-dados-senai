INSERT INTO investidores (nome,cpf,nivel_experiencia) VALUES
('Joao bobao', '12312312345',2),
('othelo fofao', '22312312345',1),
('sapo bobao', '32312312345',4),
('oloco bobao', '42312312345',1),
('sla bobao', '52312312345',5);

INSERT INTO carteiras (investidor_id,endereco_wallet,rede_blockchain,saldo_usd,status) VALUES
(1, '0x71C1110A', '$BITCOIN', 2500.00, 'Ativa'),
(2, '0x71C2220A', '$CRIPTO', 3500.00, 'Em Analise'),
(3, '0x71C3330A', '$DINHEIRO', 4500.00, 'Bloqueada'),
(4, '0x71C4440A', '$BOLO', 5500.00, 'Pausada'),
(5, '0x71C5550A', '$OLOCO', 6500.00, 'Ativa');

INSERT INTO corretoras (nome_exchange,cnpj,email_suporte) VALUES
('corretorafofa', '12345678901234','suporte@corretorafofa.com'),
('corretoramá', '22345678901234','suporte@corretoramá.com'),
('corretoracruel', '32345678901234','suporte@corretoracruel.com'),
('corretoralegal', '42345678901234','suporte@corretoraCRUEL.com'),
('corretorasla', '52345678901234','suporte@corretorasla.com');

INSERT INTO criptomoedas (corretora_id,nome_moeda,preco_unitario_usd,categoria) VALUES
(1,'$BITCOIN',100.00,'Layer1'),
(2,'$CRIPTO',100.00,'Layer1'),
(3,'$DINHEIRO',100.00,'DeFi'),
(4,'$BOLO',100.00,'Memecoin'),
(5,'$OLOCO',100.00,'Stablecoin');

INSERT INTO transacoes_cripto(carteira_id,criptomoeda_id,quantidade,valor_pago,data_transacao) VALUES
(1,1,1.00,10,'2026-10-01 10:30:00'),
(2,2,1.00,10,'2026-10-01 10:30:00'),
(3,3,1.00,10,'2026-10-01 10:30:00'),
(4,4,1.00,10,'2026-10-01 10:30:00'),
(5,5,1.00,10,'2026-10-01 10:30:00');


