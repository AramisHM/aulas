<html>

<head>
    <meta charset='utf-8'>
    <title>Aula FONT AWESOME</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .papai {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .caixa {
            background-color: azure;
            border: 1px solid black;
            margin: 20px;
        }

        .custInput {
            padding: 10px;
            border-radius: 5px;
        }
    </style>
</head>

<body>

    <div class="papai caixa">
        <div>
            <h1>Login</h1>
            <p><i class="fa-solid fa-user"></i> Nome: <input class="custInput" placeholder="João"></p>
            <p><i class="fa-solid fa-envelope"></i> Email: <input class="custInput" placeholder="joaozito@lol.com"></p>
            <p><a href="./cadastro">Cadastre-se</a></p>
            <button onclick="testaAPI()">testa api</button>
            <p id="response">____</p>
        </div>

    </div>

    <script>
        function testaAPI() {
            fetch('api.php', {
                method: 'POST'
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('response').textContent = data.message;
                })
                .catch(error => {
                    console.error('Erro:', error);
                    document.getElementById('response').textContent = 'Ocorreu um erro.';
                });
        };
    </script>

</body>

</html>