const express = require('express');
const path = require('path');
const { handleQuery } = require('./database');

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, '../public')));

// ROTAS DE USUÁRIOS
app.get('/api/usuarios', handleQuery('SELECT * FROM Usuario ORDER BY id_usuario ASC;'));
app.post('/api/usuarios', handleQuery(
  `INSERT INTO Usuario (id_usuario, nome, email, tipo, telefone, foto_perfil) VALUES ($1, $2, $3, $4, $5, 'default.png') RETURNING *;`,
  req => [req.body.id_usuario, req.body.nome, req.body.email, req.body.tipo, req.body.telefone]
));
app.delete('/api/usuarios/:id', handleQuery('DELETE FROM Usuario WHERE id_usuario = $1;', req => [req.params.id]));

// ROTAS DE ÁLBUNS
app.get('/api/albuns', handleQuery('SELECT * FROM Album ORDER BY id_album ASC;'));
app.post('/api/albuns', handleQuery(
  `INSERT INTO Album (id_album, nome_album, capa, tipo_album, data_lancamento) VALUES ($1, $2, 'capa.png', $3, $4) RETURNING *;`,
  req => [req.body.id_album, req.body.nome_album, req.body.tipo_album, req.body.data_lancamento]
));
app.delete('/api/albuns/:id', handleQuery('DELETE FROM Album WHERE id_album = $1;', req => [req.params.id]));

// MÚSICAS
app.get('/api/musicas', handleQuery('SELECT * FROM Musica ORDER BY id_musica ASC;'));
app.get('/api/musicas/busca', handleQuery('SELECT * FROM Musica WHERE nome_musica = $1;', req => [req.query.nome]));
app.post('/api/musicas', handleQuery(
  `INSERT INTO Musica (id_musica, nome_musica, faixa_audio_url, eh_explicita, registro_tom, duracao, id_album) VALUES ($1, $2, $3, FALSE, 'C', $4, $5) RETURNING *;`,
  req => [req.body.id_musica, req.body.nome_musica, req.body.faixa_audio_url, req.body.duracao, req.body.id_album]
));
app.delete('/api/musicas/:id', handleQuery('DELETE FROM Musica WHERE id_musica = $1;', req => [req.params.id]));

// PLAYLISTS
app.get('/api/playlists', handleQuery('SELECT * FROM Playlist ORDER BY id_playlist ASC;'));
app.post('/api/playlists', handleQuery(
  `INSERT INTO Playlist (id_playlist, nome_playlist, descricao, eh_privada, capa_playlist, id_criador) VALUES ($1, $2, $3, FALSE, 'playlist.png', $4) RETURNING *;`,
  req => [req.body.id_playlist, req.body.nome_playlist, req.body.descricao, req.body.id_criador]
));
app.delete('/api/playlists/:id', handleQuery('DELETE FROM Playlist WHERE id_playlist = $1;', req => [req.params.id]));

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => console.log(`Servidor rodando na porta ${PORT}`));