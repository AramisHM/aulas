CREATE TABLE IF NOT EXISTS Autor (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL);
    CREATE TABLE IF NOT EXISTS Livro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL);
    
CREATE TABLE IF NOT EXISTS Livro (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL);

CREATE TABLE IF NOT EXISTS Livro_Autor (
    id_livro INTEGER,
    id_autor INTEGER,
    FOREIGN KEY (id_livro) REFERENCES Livro (id),
    FOREIGN KEY (id_autor) REFERENCES Autor (id),
    PRIMARY KEY (id_livro, id_autor));

    -- George Orwell
    -- 1984
    -- A Revolução dos Bichos
    
    -- Ayn Rand
    -- A Revolta de Atlas