let apiUrl = 'http://localhost:5001'; // Altere para o endereço da sua API

function addAutor() {
  const nome = document.getElementById('autorNome').value;
  fetch(apiUrl + '/add_autor', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ nome: nome })
  }).then(response => response.json())
    .then(data => {
      alert('Autor adicionado: ' + data.nome);
      document.getElementById('autorNome').value = '';
    });
}

function addLivro() {
  const titulo = document.getElementById('livroTitulo').value;
  const autorId = document.getElementById('autorId').value;
  fetch(apiUrl + '/add_livro', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ titulo: titulo, autor_id: autorId })
  }).then(response => response.json())
    .then(data => {
      alert('Livro adicionado: ' + data.titulo);
      document.getElementById('livroTitulo').value = '';
      document.getElementById('autorId').value = '';
      loadLivros();
    });
}

function loadLivros() {
  fetch(apiUrl + '/livros')
    .then(response => response.json())
    .then(data => {
      const livroList = document.getElementById('livroList');
      livroList.innerHTML = '';
      data.forEach(livro => {
        const item = document.createElement('div');
        item.textContent = `Livro: ${livro[1]}, Autor: ${livro[2]}`;
        livroList.appendChild(item);
      });
    });
}
document.addEventListener('DOMContentLoaded', loadLivros);