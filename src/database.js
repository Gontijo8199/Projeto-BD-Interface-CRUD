const { Pool } = require('pg');


const pool = new Pool({
  user: 'spotifyuser',
  host: 'localhost',
  database: 'Spotify',
  password: 'spotifypass',
  port: 5432,
});

const handleQuery = (queryText, getParams) => async (req, res) => {
  try {
    const params = getParams ? getParams(req) : [];
    const result = await pool.query(queryText, params);
    

    res.json(result.rows ? result.rows : { message: 'Operação realizada com sucesso!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = {
  pool,
  handleQuery
};