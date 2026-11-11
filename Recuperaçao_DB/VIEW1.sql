CREATE VIEW vw_painel_carteiras AS 
SELECT
	c.endereco_wallet,
	c.rede_blockchain,
	c.status,
	c.saldo_usd,
	i.nome AS nome_investidor,
	i.cpf
FROM carteiras c
INNER JOIN investidores i
	on c.investidor_id = i.id;

SELECT * FROM vw_painel_carteiras