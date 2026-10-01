CREATE TABLE aeronaves (
	id SERIAL PRIMARY KEY,

    modelo VARCHAR(150) NOT NULL,

    codigo_cauda VARCHAR(10) NOT NULL UNIQUE,

    capacidade INT NOT NULL CHECK(capacidade >= 0)
);

CREATE TABLE pilotos (
	id SERIAL PRIMARY KEY,

    nome VARCHAR(150) NOT NULL,

    codigo_anac VARCHAR(6) NOT NULL UNIQUE,

    horas_voo INT DEFAULT 0 CHECK(horas_voo >= 0)
);

CREATE TABLE voos (
	id SERIAL PRIMARY KEY,

    aeronave_id INT NOT NULL REFERENCES aeronaves(id),

    piloto_id INT NOT NULL REFERENCES pilotos(id),

    numero_voo VARCHAR(150) NOT NULL,
    
    origem VARCHAR(150) NOT NULL,
    
    destino VARCHAR(150) NOT NULL,
    
    data_hora TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),
    
    status VARCHAR(150) DEFAULT('Agendado') CHECK(status IN ('Agendado', 'Em Voo', 'Concluido', 'Cancelado'))
);

CREATE TABLE passageiros (
    id SERIAL PRIMARY KEY,

    nome VARCHAR(150) NOT NULL,
    
    cpf VARCHAR(11) UNIQUE NOT NULL,
    
    email VARCHAR(150) UNIQUE NOT NULL

);

CREATE TABLE passagens (
    id SERIAL PRIMARY KEY,

    voo_id INT NOT NULL REFERENCES voos(id),
    
    passageiro_id INT NOT NULL REFERENCES passageiros(id),
    
    assento VARCHAR(4) UNIQUE NOT NULL,

    classe VARCHAR(150) DEFAULT('Economica') CHECK(classe IN ('Economica', 'Executiva')),

    valor DECIMAL(10,2) NOT NULL CHECK(valor >= 0)
);