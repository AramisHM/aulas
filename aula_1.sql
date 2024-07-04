

-----------
-- instalar o mysql-server
-- sudo mysql -u root


-- Criar um usuário
CREATE USER 'aluno1'@'localhost' IDENTIFIED BY 'Senha#1';
ALTER USER 'aluno1'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Senha#1'; -- Override SSL.
GRANT ALL PRIVILEGES ON *.* TO 'usuario'@'localhost' WITH GRANT OPTION; -- Permissão ampla (para estudar)
FLUSH PRIVILEGES; -- atualiza

----------- Modelo e Dados
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    n_paginas INT,
    estoque INT
);

CREATE TABLE emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    usuario_id INT,
    tempo_permitido_dias INT,
    data_retirada DATE,
    data_devolucao DATE,
    estado VARCHAR(100),
    FOREIGN KEY (livro_id) REFERENCES livros(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

INSERT INTO livros (titulo, n_paginas, estoque) VALUES ("A Revolta de Atlas", 1216, 1);
INSERT INTO livros (titulo, n_paginas, estoque) VALUES ("A Revolucao dos Bichos", 144, 1);
INSERT INTO usuarios (nome) VALUES ("Aramis");
INSERT INTO usuarios (nome) VALUES ("Athos");
INSERT INTO usuarios (nome) VALUES ("Porthos");

--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- EXERCICIO 1 __________ emprestar
DELIMITER //
CREATE PROCEDURE Emprestar (
    IN p_nome_usuario VARCHAR(100),
    IN p_nome_livro VARCHAR(100)
)
BEGIN
    -- calcula dias de emprestimo por paginas, cada 50 paginas 1 dia
    -- seleciona tanto usarui quanto livro por LIKE... para facilitar a call, abstrai codigo
    -- checa se tem no estoque
    -- se houver em estoque, subtrai 1, e anota na tabela emprestimo com data de hj

END //
DELIMITER ;


-- EXERCICIO 1 __________ devolver

--... siga template acima
