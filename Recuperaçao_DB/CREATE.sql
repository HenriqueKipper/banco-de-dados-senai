CREATE TABLE investidores (
id serial PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) NOT NULL UNIQUE,
nivel_experiencia INT DEFAULT 0 CHECK(nivel_experiencia >= 0)
);

CREATE TABLE carteiras (
id serial PRIMARY KEY,
investidor_id INT NOT NULL,
endereco_wallet VARCHAR(100) NOT NULL UNIQUE,
rede_blockchain VARCHAR(50) NOT NULL,
saldo_usd DECIMAL(15,2) NOT NULL CHECK(saldo_usd > 0),
status VARCHAR(20) DEFAULT 'Ativa' CHECK(status IN ('Ativa', 'Em Analise', 'Bloqueada',
'Pausada')),
FOREIGN KEY (investidor_id) REFERENCES investidores(id)
);

CREATE TABLE corretoras (
id serial PRIMARY KEY,
nome_exchange VARCHAR(100) NOT NULL,
cnpj VARCHAR(14) NOT NULL UNIQUE,
email_suporte VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE criptomoedas (
id serial PRIMARY KEY,
corretora_id INT NOT NULL,
nome_moeda VARCHAR(50) NOT NULL,
preco_unitario_usd DECIMAL(15,2) NOT NULL CHECK(preco_unitario_usd > 0),
categoria VARCHAR(20) DEFAULT 'Layer1' CHECK(categoria IN ('Layer1', 'DeFi', 'Memecoin',
'Stablecoin')),
FOREIGN KEY (corretora_id) REFERENCES corretoras(id)
);

CREATE TABLE transacoes_cripto (
id serial PRIMARY KEY,
carteira_id INT NOT NULL,
criptomoeda_id INT NOT NULL,
quantidade DECIMAL(18,7) NOT NULL CHECK(quantidade > 0),
valor_pago DECIMAL(15,2) NOT NULL CHECK(valor_pago >0),
data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(carteira_id) REFERENCES carteiras(id),
FOREIGN KEY(criptomoeda_id) REFERENCES criptomoedas(id)
)
