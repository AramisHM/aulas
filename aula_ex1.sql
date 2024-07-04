-- SOLUCAO EX1

-- EXERCICIO 1: emprestar
DROP PROCEDURE IF EXISTS Emprestar;
DELIMITER //
CREATE PROCEDURE Emprestar (
    IN p_nome_usuario VARCHAR(100),
    IN p_nome_livro VARCHAR(100)
)
BEGIN
    DECLARE v_usuario_id INT;
    DECLARE v_livro_id INT;
    DECLARE v_n_paginas INT;
    DECLARE v_estoque INT;
    DECLARE v_tempo_permitido_dias INT;
    DECLARE v_data_retirada DATE;
    
    -- Localiza o usuário pelo nome
    SELECT id INTO v_usuario_id 
    FROM usuarios 
    WHERE nome LIKE p_nome_usuario 
    LIMIT 1;
    
    -- Localiza o livro pelo título
    SELECT id, n_paginas, estoque INTO v_livro_id, v_n_paginas, v_estoque
    FROM livros 
    WHERE titulo LIKE p_nome_livro 
    LIMIT 1;
    
    -- Verifica se o livro está em estoque
    IF v_estoque > 0 THEN
        -- Calcula o tempo permitido de empréstimo (1 dia a cada 50 páginas)
        SET v_tempo_permitido_dias = CEIL(v_n_paginas / 50);
        
        -- Data de retirada é a data atual
        SET v_data_retirada = CURDATE();
        
        -- Insere o registro de empréstimo
        INSERT INTO emprestimos (livro_id, usuario_id, tempo_permitido_dias, data_retirada, data_devolucao, estado)
        VALUES (v_livro_id, v_usuario_id, v_tempo_permitido_dias, v_data_retirada, NULL, 'emprestado');
        
        -- Atualiza o estoque do livro
        UPDATE livros
        SET estoque = estoque - 1
        WHERE id = v_livro_id;
    ELSE
        -- Se o livro não está em estoque, pode-se lançar um erro ou mensagem
        -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Livro não está em estoque';
        SELECT 'Livro não está em estoque' AS mensagem;
    END IF;
END //
DELIMITER ;

CALL Emprestar('Aramis', 'A Revolta de Atlas');