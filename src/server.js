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



// READ ALL 
app.get('/api/musicas', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM "Musica" ORDER BY id ASC;');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// READ ONE 
app.get('/api/musicas/busca', async (req, res) => {
  const { titulo } = req.query;
  try {
    const result = await pool.query('SELECT * FROM "Musica" WHERE titulo = $1;', [titulo]);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// CREATE 
app.post('/api/musicas', async (req, res) => {
  const { titulo, duracao } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO "Musica" (titulo, duracao) VALUES ($1, $2) RETURNING *;',
      [titulo, duracao]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//  UPDATE
app.put('/api/musicas/:id', async (req, res) => {
  const { id } = req.params;
  const { titulo, duracao } = req.body;
  try {
    await pool.query('UPDATE "Musica" SET titulo = $1, duracao = $2 WHERE id = $3;', [titulo, duracao, id]);
    res.json({ message: 'Música atualizada com sucesso!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE 
app.delete('/api/musicas/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query('DELETE FROM "Musica" WHERE id = $1;', [id]);
    res.json({ message: 'Música removida com sucesso!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));