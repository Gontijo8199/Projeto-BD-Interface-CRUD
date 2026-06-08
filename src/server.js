const express = require('express');
const { Pool } = require('pg');
const path = require('path');

const app = express();
app.use(express.json());

app.use(express.static(path.join(__dirname, '../public')));

const pool = new Pool({
  user: 'spotifyuser',
  host: 'localhost',
  database: 'Spotify',
  password: 'spotifypass',
  port: 5432,
});

const executarSQL = async (res, query, params = []) => {
  try {
    const resultado = await pool.query(query, params);
    res.json(resultado.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

app.get('/api/usuarios', (req, res) => executarSQL(res, 'SELECT * FROM Usuario ORDER BY id_usuario;'));
app.get('/api/usuarios/busca', (req, res) => {
  const termo = req.query.nome || '';
  executarSQL(res, 'SELECT * FROM Usuario WHERE nome ILIKE $1 ORDER BY id_usuario;', [`%${termo}%`]);
});
app.post('/api/usuarios', (req, res) => {
  const { id_usuario, nome, email, telefone, tipo } = req.body;
  executarSQL(res, 'INSERT INTO Usuario (id_usuario, nome, email, telefone, tipo) VALUES ($1, $2, $3, $4, $5) RETURNING *;', [id_usuario, nome, email, telefone, tipo]);
});
app.put('/api/usuarios/:id', (req, res) => {
  const { nome, email, telefone, tipo } = req.body;
  executarSQL(res, 'UPDATE Usuario SET nome=$1, email=$2, telefone=$3, tipo=$4 WHERE id_usuario=$5 RETURNING *;', [nome, email, telefone, tipo, req.params.id]);
});
app.delete('/api/usuarios/:id', (req, res) => executarSQL(res, 'DELETE FROM Usuario WHERE id_usuario=$1 RETURNING *;', [req.params.id]));

app.get('/api/albuns', (req, res) => executarSQL(res, 'SELECT * FROM Album ORDER BY id_album;'));
app.get('/api/albuns/busca', (req, res) => executarSQL(res, 'SELECT * FROM Album WHERE nome_album ILIKE $1;', [`%${req.query.nome}%`]));
app.post('/api/albuns', (req, res) => {
  const { id_album, nome_album, tipo_album, data_lancamento } = req.body;
  executarSQL(res, 'INSERT INTO Album (id_album, nome_album, tipo_album, data_lancamento) VALUES ($1, $2, $3, $4) RETURNING *;', [id_album, nome_album, tipo_album, data_lancamento]);
});
app.put('/api/albuns/:id', (req, res) => {
  const { nome_album, tipo_album, data_lancamento } = req.body;
  executarSQL(res, 'UPDATE Album SET nome_album=$1, tipo_album=$2, data_lancamento=$3 WHERE id_album=$4 RETURNING *;', [nome_album, tipo_album, data_lancamento, req.params.id]);
});
app.delete('/api/albuns/:id', (req, res) => executarSQL(res, 'DELETE FROM Album WHERE id_album=$1 RETURNING *;', [req.params.id]));

app.get('/api/musicas', (req, res) => executarSQL(res, 'SELECT * FROM Musica ORDER BY id_musica;'));
app.get('/api/musicas/busca', (req, res) => executarSQL(res, 'SELECT * FROM Musica WHERE nome_musica = $1;', [req.query.nome]));
app.post('/api/musicas', (req, res) => {
  const { id_musica, nome_musica, faixa_audio_url, duracao, id_album } = req.body;
  executarSQL(res, 'INSERT INTO Musica (id_musica, nome_musica, faixa_audio_url, duracao, id_album) VALUES ($1, $2, $3, $4, $5) RETURNING *;', [id_musica, nome_musica, faixa_audio_url, duracao, id_album]);
});
app.put('/api/musicas/:id', (req, res) => {
  const { nome_musica, faixa_audio_url, duracao, id_album } = req.body;
  executarSQL(res, 'UPDATE Musica SET nome_musica=$1, faixa_audio_url=$2, duracao=$3, id_album=$4 WHERE id_musica=$5 RETURNING *;', [nome_musica, faixa_audio_url, duracao, id_album, req.params.id]);
});
app.delete('/api/musicas/:id', (req, res) => executarSQL(res, 'DELETE FROM Musica WHERE id_musica=$1 RETURNING *;', [req.params.id]));

app.get('/api/playlists', (req, res) => executarSQL(res, 'SELECT * FROM Playlist ORDER BY id_playlist;'));
app.get('/api/playlists/busca', (req, res) => executarSQL(res, 'SELECT * FROM Playlist WHERE nome_playlist ILIKE $1;', [`%${req.query.nome}%`]));
app.post('/api/playlists', (req, res) => {
  const { id_playlist, nome_playlist, descricao, id_criador } = req.body;
  executarSQL(res, 'INSERT INTO Playlist (id_playlist, nome_playlist, descricao, id_criador) VALUES ($1, $2, $3, $4) RETURNING *;', [id_playlist, nome_playlist, descricao, id_criador]);
});
app.put('/api/playlists/:id', (req, res) => {
  const { nome_playlist, descricao, id_criador } = req.body;
  executarSQL(res, 'UPDATE Playlist SET nome_playlist=$1, descricao=$2, id_criador=$3 WHERE id_playlist=$4 RETURNING *;', [nome_playlist, descricao, id_criador, req.params.id]);
});
app.delete('/api/playlists/:id', (req, res) => executarSQL(res, 'DELETE FROM Playlist WHERE id_playlist=$1 RETURNING *;', [req.params.id]));

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando com sucesso na porta ${PORT}`);
});