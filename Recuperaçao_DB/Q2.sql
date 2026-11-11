SELECT 
	co.nome_exchange,
	SUM(t.valor_pago) AS total_movimentado
FROM corretoras co
INNER JOIN criptomoedas cr
	ON co.id = cr.corretora_id
INNER JOIN transacoes_cripto t
	ON cr.id = t.criptomoeda_id
GROUP BY co.id, co.nome_exchange
ORDER BY total_movimentado DESC;