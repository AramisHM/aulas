-- SOLUCAO EX3

-- EXERCICIO 3: devolver com multa
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
    SET @multa_resultado = 0.00; -- EX3_2

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

        CALL CalcularMulta(v_emprestimo_id, @multa_resultado); -- EX3_2
        -- Exemplo de uso de IF com variável de sessão
        IF @multa_resultado > 0 THEN -- EX3_2
            SELECT CONCAT('A multa calculada é de R$', @multa_resultado) AS mensagem; -- EX3_2
        ELSE
            SELECT 'Não há multa para este empréstimo' AS mensagem; -- EX3_2
        END IF;
    END IF;
END //
DELIMITER ;

CALL Devolver('Aramis', 'A Revolta de Atlas');