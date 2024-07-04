-- SOLUCAO EX2

-- EXERCICIO 2: multa
DROP PROCEDURE IF EXISTS CalcularMulta;
DELIMITER //
CREATE PROCEDURE CalcularMulta (
    IN p_emprestimo_id INT,
    OUT p_multa DECIMAL(10, 2)
)
BEGIN
    DECLARE v_dias_atraso INT;
    DECLARE v_multa DECIMAL(10, 2);
    DECLARE v_data_retirada DATE;
    DECLARE v_tempo_permitido_dias INT;

    -- Obter dados do empréstimo
    SELECT data_retirada, tempo_permitido_dias INTO v_data_retirada, v_tempo_permitido_dias
    FROM emprestimos
    WHERE id = p_emprestimo_id;
    
    -- Calcular os dias de atraso
    SET v_dias_atraso = DATEDIFF(CURDATE(), v_data_retirada) - v_tempo_permitido_dias; -- logica de inicializacao
    
    -- Se os dias de atraso forem menores que zero, então não há atraso
    IF v_dias_atraso < 0 THEN
        SET v_dias_atraso = 0;
    END IF;
    
    -- Calcular a multa
    SET v_multa = v_dias_atraso * 2;
    
    -- Limitar a multa ao máximo de R$100
    IF v_multa > 100 THEN
        SET v_multa = 100;
    END IF;
    
    -- Retornar a multa calculada
    SET p_multa = v_multa;
END //
DELIMITER ;


-- _________________
-- Declare uma variável de sessão para armazenar a multa
SET @multa_resultado = 0.00;

-- Chame a stored procedure e passe a variável de sessão como parâmetro de saída
CALL CalcularMulta(seu_emprestimo_id, @multa_resultado);

-- Exemplo de uso de IF com variável de sessão
IF @multa_resultado > 0 THEN
    SELECT CONCAT('A multa calculada é de R$', @multa_resultado) AS mensagem;
ELSE
    SELECT 'Não há multa para este empréstimo' AS mensagem;
END IF;

---_____________________
---_____________________
---_____________________