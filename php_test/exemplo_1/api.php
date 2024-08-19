<?php
// boilerplate que é necessario. Sera?
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); 


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Resposta JSON
    $response = array("message" => "Ola! perfeito funciona!");
    echo json_encode($response);
} else {
    http_response_code(405); // Método não permitido
    echo json_encode(array("error" => "Método não permitido"));
} 
?>