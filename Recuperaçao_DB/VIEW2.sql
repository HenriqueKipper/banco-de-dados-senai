CREATE VIEW vw_investimento_total_carteiras AS 
SELECT
	c.id AS id_carteira,
	c.endereco_wallet,
	c.saldo_usd,
	COUNT(t.id) AS total_transacoes,
	COALESCE(SUM(t.valor_pago), 0) AS custo_total_compras
FROM carteiras c
LEFT JOIN transacoes_cripto t
	ON c.id = t.carteira_id
GROUP BY
	c.id,
	c.endereco_wallet,
	c.saldo_usd;

SELECT * FROM vw_investimento_total_carteiras