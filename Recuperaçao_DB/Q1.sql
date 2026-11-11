SELECT
	c.endereco_wallet,
	c.rede_blockchain,
	c.saldo_usd,
	i.nome,
	i.cpf
FROM carteiras c
INNER JOIN investidores i
	ON c.investidor_id = i.id
WHERE c.status IN ('Ativa', 'Em Analise');