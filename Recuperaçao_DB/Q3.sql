SELECT 
	c.endereco_wallet,
	cr.nome_moeda,
	t.quantidade,
	t.valor_pago,
	t.data_transacao
FROM transacoes_cripto t
INNER JOIN carteiras c
	ON t.carteira_id = c.id
INNER JOIN criptomoedas cr
	ON t.criptomoeda_id = cr.id
WHERE t.valor_pago > 500
ORDER BY t.valor_pago DESC;