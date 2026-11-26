
-- ==========================================
-- 1. LIMPEZA DAS ESTRUTURAS
-- ==========================================

DROP VIEW IF EXISTS vw_cronograma_prazos;
DROP VIEW IF EXISTS vw_painel_principal;

DROP TABLE IF EXISTS historico_tarefas CASCADE;
DROP TABLE IF EXISTS tarefas CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS colaboradores CASCADE;


-- ==========================================
-- 2. CRIACAO DAS TABELAS
-- ==========================================

CREATE TABLE colaboradores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT
);


CREATE TABLE tarefas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    colaborador_id INT NOT NULL,
    categoria_id INT NOT NULL,
    data_agendamento DATE NOT NULL,
    prazo_entrega DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_tarefa_colaborador
        FOREIGN KEY (colaborador_id)
        REFERENCES colaboradores(id),

    CONSTRAINT fk_tarefa_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id),

    CONSTRAINT chk_prazo
        CHECK (prazo_entrega >= data_agendamento),

    CONSTRAINT chk_status
        CHECK (status IN (
            'Pendente',
            'Em andamento',
            'Concluida',
            'Cancelada'
        ))
);


CREATE TABLE historico_tarefas (
    id SERIAL PRIMARY KEY,
    tarefa_id INT NOT NULL,
    evento TEXT NOT NULL,
    data_evento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historico_tarefa
        FOREIGN KEY (tarefa_id)
        REFERENCES tarefas(id)
        ON DELETE CASCADE
);


-- ==========================================
-- 3. FUNCTION DE VALIDACAO DA TAREFA
-- ==========================================

CREATE OR REPLACE FUNCTION fn_validar_tarefa()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM colaboradores
        WHERE id = NEW.colaborador_id
          AND ativo = TRUE
    ) THEN
        RAISE EXCEPTION
        'Colaborador inexistente ou inativo.';
    END IF;

    NEW.data_criacao := CURRENT_TIMESTAMP;

    RETURN NEW;
END;
$$;


-- ==========================================
-- 4. TRIGGER DE VALIDACAO
-- ==========================================

CREATE TRIGGER trg_validar_tarefa
BEFORE INSERT ON tarefas
FOR EACH ROW
EXECUTE FUNCTION fn_validar_tarefa();


-- ==========================================
-- 5. FUNCTION DE REGISTRO DO HISTORICO
-- ==========================================

CREATE OR REPLACE FUNCTION fn_registrar_historico_tarefa()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO historico_tarefas (tarefa_id, evento)
    VALUES (
        NEW.id,
        'Tarefa criada: ' || NEW.titulo
    );

    RETURN NEW;
END;
$$;


-- ==========================================
-- 6. TRIGGER DO HISTORICO
-- ==========================================

CREATE TRIGGER trg_registrar_historico
AFTER INSERT ON tarefas
FOR EACH ROW
EXECUTE FUNCTION fn_registrar_historico_tarefa();


-- ==========================================
-- 7. INSERCA DE COLABORADORES
-- ==========================================

INSERT INTO colaboradores (nome, email, senha, ativo)
VALUES
('Carlos Mendes', 'carlos@empresa.com', '123456', TRUE),
('Ana Souza', 'ana@empresa.com', 'abc123', TRUE),
('Pedro Lima', 'pedro@empresa.com', 'senha123', FALSE);


-- ==========================================
-- 8. INSERCA DE CATEGORIAS
-- ==========================================

INSERT INTO categorias (nome, descricao)
VALUES
('Desenvolvimento', 'Desenvolvimento de sistemas'),
('Design', 'Criacao de interfaces e identidade visual'),
('Administrativo', 'Organizacao administrativa');


-- ==========================================
-- 9. INSERCA DE TAREFAS
-- ==========================================

INSERT INTO tarefas
(titulo, descricao, colaborador_id, categoria_id,
 data_agendamento, prazo_entrega, status)
VALUES
(
    'Criar sistema de login',
    'Desenvolver autenticacao de usuarios',
    1, 1,
    CURRENT_DATE,
    CURRENT_DATE + 5,
    'Em andamento'
),
(
    'Criar identidade visual',
    'Desenvolver layout inicial',
    2, 2,
    CURRENT_DATE,
    CURRENT_DATE + 3,
    'Pendente'
),
(
    'Organizar documentos',
    'Revisar documentos da empresa',
    1, 3,
    CURRENT_DATE,
    CURRENT_DATE + 10,
    'Pendente'
);


-- ==========================================
-- 10. FUNCTION DE BUSCA DE COLABORADORES
-- ==========================================

CREATE OR REPLACE FUNCTION fn_buscar_colaboradores(
    termo TEXT
)
RETURNS TABLE (
    id INT,
    nome VARCHAR(100),
    email VARCHAR(150),
    ativo BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.id,
        c.nome,
        c.email,
        c.ativo
    FROM colaboradores c
    WHERE c.nome ILIKE '%' || termo || '%'
       OR c.email ILIKE '%' || termo || '%';
END;
$$;


-- ==========================================
-- 11. VIEW DO PAINEL PRINCIPAL
-- ==========================================

CREATE OR REPLACE VIEW vw_painel_principal AS
SELECT
    c.nome AS colaborador,
    t.titulo AS tarefa,
    cat.nome AS categoria,
    t.prazo_entrega,
    t.status
FROM tarefas t
INNER JOIN colaboradores c
    ON t.colaborador_id = c.id
INNER JOIN categorias cat
    ON t.categoria_id = cat.id;


-- ==========================================
-- 12. VIEW DO CRONOGRAMA
-- ==========================================

CREATE OR REPLACE VIEW vw_cronograma_prazos AS
SELECT
    t.id AS tarefa_id,
    t.titulo AS tarefa,
    c.nome AS responsavel,
    cat.nome AS categoria,
    t.data_agendamento,
    t.prazo_entrega,
    t.status,
    (t.prazo_entrega - CURRENT_DATE) AS dias_restantes
FROM tarefas t
INNER JOIN colaboradores c
    ON t.colaborador_id = c.id
INNER JOIN categorias cat
    ON t.categoria_id = cat.id
ORDER BY t.prazo_entrega ASC;


-- ==========================================
-- 13. CONSULTAS DE TESTE
-- ==========================================

-- Painel principal
SELECT * FROM vw_painel_principal;

-- Cronograma de prazos
SELECT * FROM vw_cronograma_prazos;

-- Busca de colaboradores
SELECT * FROM fn_buscar_colaboradores('ana');

-- Historico de tarefas
SELECT * FROM historico_tarefas;

-- Teste de colaboradores
SELECT * FROM colaboradores;
