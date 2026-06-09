-- Análise comparativa da performançe do banco de dados na consulta com índice vs sem índice

-- Parte 01: busca sem índice (sequencial)
\echo 'Busca sem índice: \n\n'

-- Parte 01.a: buscas por um único elemento 

-- seleção de música pelo nome
EXPLAIN ANALYZE VERBOSE SELECT * FROM musica m 
WHERE m.nome_musica = 'Faixa 18 - Album 0224';

-- seleção de usuário pelo nome
EXPLAIN ANALYZE VERBOSE SELECT * FROM usuario u 
WHERE u.nome = 'ouvinte_04412';

-- seleção de album pelo nome
EXPLAIN ANALYZE VERBOSE SELECT * FROM album a 
WHERE a.nome_album = 'Coletânea Rock Vol. 13';

-- Parte 01.b: busca por múltiplos elementos 

-- últimas músicas ouvidas por um usuário
EXPLAIN ANALYZE VERBOSE SELECT 
    u.id_usuario, u.nome, m.nome_musica, a.nome_album, m.duracao
FROM usuario u 
    JOIN ouvinte_escuta_musica om ON om.id_ouvinte = u.id_usuario
    JOIN musica m ON m.id_musica = om.id_musica
    JOIN album a ON a.id_album = m.id_album
WHERE u.nome = 'ouvinte_04412' 
ORDER BY om.id_registro DESC
LIMIT 50;

-- Parte 02: busca com índice (binária)
\echo 'Busca com índice: \n\n'

-- Parte 02.a: buscas por um único elemento 

-- seleção de música pelo nome
CREATE INDEX nome_musica_idx ON musica(nome_musica); 

EXPLAIN ANALYZE VERBOSE SELECT * FROM musica m 
WHERE m.nome_musica = 'Faixa 18 - Album 0224';

DROP INDEX nome_musica_idx;

-- seleção de usuário pelo nome
CREATE INDEX nome_usr_idx ON usuario(nome); 

EXPLAIN ANALYZE VERBOSE SELECT * FROM usuario u 
WHERE u.nome = 'ouvinte_04412';

DROP INDEX nome_usr_idx;

-- seleção de album pelo nome
CREATE INDEX nome_album_idx ON album(nome_album); 

EXPLAIN ANALYZE VERBOSE SELECT * FROM album a 
WHERE a.nome_album = 'Coletânea Rock Vol. 13';

DROP INDEX nome_album_idx;

-- Parte 02.b: busca por múltiplos elementos 

-- últimas músicas ouvidas por um usuário
CREATE INDEX nome_usr_idx ON usuario(nome);
CREATE INDEX om_id_ouv_idx ON ouvinte_escuta_musica(id_ouvinte);

EXPLAIN ANALYZE VERBOSE SELECT 
    u.id_usuario, u.nome, m.nome_musica, a.nome_album, m.duracao
FROM usuario u 
    JOIN ouvinte_escuta_musica om ON om.id_ouvinte = u.id_usuario
    JOIN musica m ON m.id_musica = om.id_musica
    JOIN album a ON a.id_album = m.id_album
WHERE u.nome = 'ouvinte_04412' 
ORDER BY om.id_registro DESC
LIMIT 50;

DROP INDEX nome_usr_idx;
DROP INDEX om_id_ouv_idx;