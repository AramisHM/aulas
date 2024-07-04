-- SOLUCAO EX2

-- EXERCICIO 2: devolver
DROP PROCEDURE IF EXISTS Devolver;
DELIMITER //
CREATE PROCEDURE Devolver (
    IN p_nome_usuario VARCHAR(100),
    IN p_nome_livro VARCHAR(100)
)
BEGIN
    DECLARE v_usuario_id INT;
    DECLARE v_livro_id INT;
    DECLARE v_emprestimo_id INT;

    DECLARE v_tempo_permitido_dias INT;
    DECLARE v_data_devolucao DATE;
    
    -- id usuário
    SELECT id INTO v_usuario_id 
    FROM usuarios 
    WHERE nome LIKE p_nome_usuario 
    LIMIT 1;
    
    -- id livro
    SELECT id INTO v_livro_id
    FROM livros 
    WHERE titulo LIKE p_nome_livro 
    LIMIT 1;

    -- id emprestimo
    SELECT id INTO v_emprestimo_id
    FROM emprestimos 
    WHERE livro_id = v_livro_id and usuario_id = v_usuario_id and estado = "emprestado"
    LIMIT 1;
    
    -- update emprestimo
    IF v_emprestimo_id > 0 THEN
        
        UPDATE emprestimos 
        SET
            data_devolucao = CURDATE(),
            estado = "devolvido"
        WHERE id = v_emprestimo_id;
        
        -- Atualiza o estoque do livro
        UPDATE livros
        SET estoque = estoque + 1
        WHERE id = v_livro_id;
    ELSE
        -- Se o livro não está em estoque, pode-se lançar um erro ou mensagem
        -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Livro não está em estoque';
        SELECT 'Nao esxiste emprestimo para livro e usuario especificado' AS mensagem;
    END IF;
END //
DELIMITER ;
CALL Devolver('Aramis', 'A Revolta de Atlas');