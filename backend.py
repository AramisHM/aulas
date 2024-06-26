from flask import Flask, request, jsonify
import sqlite3
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # ativa cor para aceitar requests de dominios diferentes
dbname = "library.db"

@app.route('/add_autor', methods=['POST'])
def add_autor():
    nome = request.json['nome']
    with sqlite3.connect(dbname) as conn:
        cursor = conn.cursor()
        cursor.execute('INSERT INTO Autor (nome) VALUES (?)', (nome,))
        conn.commit()
        autor_id = cursor.lastrowid
    return jsonify({'id': autor_id, 'nome': nome})

@app.route('/add_livro', methods=['POST'])
def add_livro():
    titulo = request.json['titulo']
    autor_id = request.json['autor_id']
    with sqlite3.connect(dbname) as conn:
        cursor = conn.cursor()
        cursor.execute('INSERT INTO Livro (titulo) VALUES (?)', (titulo,))
        conn.commit()
        livro_id = cursor.lastrowid
        cursor.execute('INSERT INTO Livro_Autor (id_livro, id_autor) VALUES (?, ?)', (livro_id, autor_id))
        conn.commit()
    return jsonify({'id': livro_id, 'titulo': titulo})

@app.route('/livros')
def get_livros():
    with sqlite3.connect(dbname) as conn:
        cursor = conn.cursor()
        cursor.execute('''SELECT Livro.id, Livro.titulo, Autor.nome FROM Livro
                          JOIN Livro_Autor ON Livro.id = Livro_Autor.id_livro
                          JOIN Autor ON Autor.id = Livro_Autor.id_autor''')
        livros = cursor.fetchall()
    return jsonify(livros)

if __name__ == '__main__':
    app.run(debug=True, port=5001)