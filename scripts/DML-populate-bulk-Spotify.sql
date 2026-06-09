-- ==============================================================
--  SCRIPT DE POPULAÇÃO EM MASSA – Spotify DB
--  Objetivo: gerar dados suficientes para comparação
--            busca sequencial vs. busca com índice
--
--  Volumes gerados (ALÉM dos já existentes):
--    Usuários/Artistas  : +30 artistas  (ids 11–40)
--    Usuários/Ouvintes  : +50 ouvintes  (ids 41–90)
--    Álbuns             : +75 álbuns    (ids 7–81)
--    Músicas            : ~4 500 músicas (ids 18–~4500)
--    Artista_Album      : mapeamento artista → álbum
--    Artista_Musica     : mapeamento artista → música
--    Musica_Genero      : gênero por música
--    Ouvinte_Escuta_Musica : ~20 000 registros de escuta
-- ==============================================================

-- ---------------------------------------------------------------
-- 1. 30 NOVOS ARTISTAS
-- ---------------------------------------------------------------
INSERT INTO Usuario (id_usuario, foto_perfil, nome, telefone, email, tipo) VALUES
(11,  'foto11.jpg',  'bandaneon',         '(11) 91111-0001', 'bandaneon@mail.com',         'Artista'),
(12,  'foto12.jpg',  'omarelo',           '(11) 91111-0002', 'omarelo@mail.com',           'Artista'),
(13,  'foto13.jpg',  'luanalucia',        '(21) 91111-0003', 'luanalucia@mail.com',         'Artista'),
(14,  'foto14.jpg',  'caetanovelosooff',  '(21) 91111-0004', 'caetanovelosooff@mail.com',   'Artista'),
(15,  'foto15.jpg',  'gilbertogil_ofc',   '(21) 91111-0005', 'gilbertogil@mail.com',        'Artista'),
(16,  'foto16.jpg',  'djguh',             '(31) 91111-0006', 'djguh@mail.com',              'Artista'),
(17,  'foto17.jpg',  'ivete_sangalo',     '(71) 91111-0007', 'ivete@mail.com',              'Artista'),
(18,  'foto18.jpg',  'anita_mc',          '(11) 91111-0008', 'anita@mail.com',              'Artista'),
(19,  'foto19.jpg',  'emicida_rap',       '(11) 91111-0009', 'emicida@mail.com',            'Artista'),
(20,  'foto20.jpg',  'projota_ofc',       '(11) 91111-0010', 'projota@mail.com',            'Artista'),
(21,  'foto21.jpg',  'djadvinha',         '(11) 91111-0011', 'djadvinha@mail.com',          'Artista'),
(22,  'foto22.jpg',  'rubel_musica',      '(21) 91111-0012', 'rubel@mail.com',              'Artista'),
(23,  'foto23.jpg',  'iza_cantora',       '(21) 91111-0013', 'iza@mail.com',                'Artista'),
(24,  'foto24.jpg',  'criolo_rapper',     '(11) 91111-0014', 'criolo@mail.com',             'Artista'),
(25,  'foto25.jpg',  'melim_band',        '(11) 91111-0015', 'melim@mail.com',              'Artista'),
(26,  'foto26.jpg',  'fresno_band',       '(51) 91111-0016', 'fresno@mail.com',             'Artista'),
(27,  'foto27.jpg',  'titas_rock',        '(11) 91111-0017', 'titas@mail.com',              'Artista'),
(28,  'foto28.jpg',  'legiao_urbana',     '(61) 91111-0018', 'legiao@mail.com',             'Artista'),
(29,  'foto29.jpg',  'raimundos_ofc',     '(61) 91111-0019', 'raimundos@mail.com',          'Artista'),
(30,  'foto30.jpg',  'djavan_musica',     '(82) 91111-0020', 'djavan@mail.com',             'Artista'),
(31,  'foto31.jpg',  'marisa_monte',      '(21) 91111-0021', 'marisa@mail.com',             'Artista'),
(32,  'foto32.jpg',  'maria_rita',        '(21) 91111-0022', 'maririta@mail.com',           'Artista'),
(33,  'foto33.jpg',  'zeca_pagodinho',    '(21) 91111-0023', 'zeca@mail.com',               'Artista'),
(34,  'foto34.jpg',  'thiaginho_ofc',     '(21) 91111-0024', 'thiaginho@mail.com',          'Artista'),
(35,  'foto35.jpg',  'ludmilla_mc',       '(21) 91111-0025', 'ludmilla@mail.com',           'Artista'),
(36,  'foto36.jpg',  'xand_aviao',        '(85) 91111-0026', 'xand@mail.com',               'Artista'),
(37,  'foto37.jpg',  'banda_calcinha',    '(85) 91111-0027', 'calcinha@mail.com',           'Artista'),
(38,  'foto38.jpg',  'gusttavo_lima',     '(64) 91111-0028', 'gusttavo@mail.com',           'Artista'),
(39,  'foto39.jpg',  'wesley_safadao',    '(85) 91111-0029', 'safadao@mail.com',            'Artista'),
(40,  'foto40.jpg',  'jorge_mateus',      '(65) 91111-0030', 'jorgemateus@mail.com',        'Artista');

INSERT INTO Artista (id_usuario, n_ouvintes, biografia, agenda_show) VALUES
(11,  450000,   'Bandas de neônio e soul', 'Show: 01/11 SP'),
(12,  380000,   'Pop alternativo mineiro', 'Show: 10/11 BH'),
(13,  910000,   'Voz marcante do sertanejo moderno', 'Tour: Brasil 2025'),
(14,  5000000,  'Ícone da MPB tropicalista', '--'),
(15,  4800000,  'Lenda da MPB e rock brasileiro', '--'),
(16,  2200000,  'Funk ostentação e baile', 'Show: todo final de semana'),
(17,  8000000,  'Rainha do axé e forró', 'Tour: Nordeste 2025'),
(18,  7500000,  'MC Pop do Brasil', 'Show: 05/12 RJ'),
(19,  3100000,  'Rap consciente de SP', 'Show: 22/11 SP'),
(20,  1200000,  'Rap e pop do ABC paulista', 'Show: 14/12 SP'),
(21,  980000,   'DJ de eletrônica BR', 'Club: Sextas'),
(22,  620000,   'Cantor independente carioca', 'Show: 08/11 RJ'),
(23,  2900000,  'R&B e Pop afro-brasileiro', 'Tour: Brasil 2025'),
(24,  1800000,  'Rapper e poeta da periferia', 'Show: 30/11 SP'),
(25,  3400000,  'Trio pop da família', 'Tour: Sul 2025'),
(26,  1100000,  'Post-punk gaúcho', 'Tour: Brasil 2025'),
(27,  2700000,  'Rock brasileiro dos 80', '--'),
(28,  9900000,  'Banda mais amada do rock nacional', '--'),
(29,  2100000,  'Punk rock brasiliense', 'Show: 20/01 DF'),
(30,  3600000,  'MPB alagoana com jazz', '--'),
(31,  4200000,  'Pop-MPB da Mangueira', 'Tour: 2025'),
(32,  3800000,  'Herdeira da MPB', 'Show: 15/12 SP'),
(33,  5500000,  'Rei do pagode', '--'),
(34,  4100000,  'Pagode romântico', 'Tour: Brasil'),
(35,  6700000,  'Funkeira do Brasil', 'Show: 01/12 RJ'),
(36,  5200000,  'Forró universitário e axé', 'Tour: 2025'),
(37,  4700000,  'Forró pé-de-serra', 'Tour: Nordeste'),
(38,  6300000,  'Sertanejo universitário', 'Tour: Brasil 2025'),
(39,  7100000,  'Forró e sertanejo raiz', 'Tour: Brasil 2025'),
(40,  5900000,  'Dupla sertaneja', 'Tour: 2025');

-- ---------------------------------------------------------------
-- 2. 5000 NOVOS OUVINTES 
-- ---------------------------------------------------------------
INSERT INTO Usuario (id_usuario, foto_perfil, nome, telefone, email, tipo)
SELECT
    40 + gs                                          AS id_usuario,
    'ouv' || (90 + gs) || '.jpg'                     AS foto_perfil,
    'ouvinte_' || LPAD(gs::TEXT, 5, '0')             AS nome,
    '(' || (10 + gs % 89) || ') 9'
        || LPAD((gs * 7919 % 90000 + 10000)::TEXT, 8, '0') AS telefone,
    'ouvinte_' || LPAD(gs::TEXT, 5, '0') || '@mail.com' AS email,
    'Ouvinte'                                        AS tipo
FROM generate_series(1, 5000) AS gs;
 
INSERT INTO Ouvinte (id_usuario, id_plano, forma_pagamento)
SELECT
    40 + gs,
    -- distribui planos: 40% gratuito, 25% estudante, 25% premium, 10% familia
    CASE (gs % 10)
        WHEN 0 THEN 1000  WHEN 1 THEN 1000  WHEN 2 THEN 1000  WHEN 3 THEN 1000
        WHEN 4 THEN 1001  WHEN 5 THEN 1001  WHEN 6 THEN 1002  WHEN 7 THEN 1002
        WHEN 8 THEN 1002  ELSE 1004
    END,
    CASE (gs % 3)
        WHEN 0 THEN 'Cartão de Crédito'
        WHEN 1 THEN 'Pix'
        ELSE        'Boleto'
    END
FROM generate_series(1, 5000) AS gs;

-- ---------------------------------------------------------------
-- 3. 1400 NOVOS ÁLBUNS
-- ---------------------------------------------------------------

INSERT INTO Album (id_album, tipo_album, capa, nome_album, data_lancamento)
SELECT
    6 + gs                                     AS id_album,
    (ARRAY['LP','EP','Single','LP','LP'])[ (gs % 5) + 1 ] AS tipo_album,
    'alb' || (6 + gs) || '.jpg'               AS capa,
    CASE (gs % 7)
        WHEN 0 THEN 'Coletânea Rock Vol.'      || gs
        WHEN 1 THEN 'Hits Nacionais Vol.'      || gs
        WHEN 2 THEN 'MPB Clássico Vol.'        || gs
        WHEN 3 THEN 'Forró Universitário Vol.' || gs
        WHEN 4 THEN 'Funk Hits Vol.'           || gs
        WHEN 5 THEN 'Sertanejo Gold Vol.'      || gs
        ELSE        'Indie BR Vol.'            || gs
    END                                         AS nome_album,
    1980 + (gs % 46)                            AS data_lancamento
FROM generate_series(1, 1400) AS gs;

-- ---------------------------------------------------------------
-- 4. MAPEAMENTO ARTISTA → ÁLBUM
-- ---------------------------------------------------------------

INSERT INTO Artista_Album (id_artista, id_album)
SELECT
    11 + ((gs - 1) % 30)   AS id_artista,   -- roda pelos novos artistas
    6 + gs                 AS id_album
FROM generate_series(1, 1400) AS gs;

-- ---------------------------------------------------------------
-- 5. 28000 MÚSICAS 
-- ---------------------------------------------------------------

-- Formato: nome "Faixa NN - Album AAAA", duracao entre 120 e 360 s
INSERT INTO Musica (id_musica, nome_musica, faixa_audio_url, eh_explicita, registro_tom, duracao, id_album)
SELECT
    -- id sequencial a partir de 18
    17 + ROW_NUMBER() OVER (ORDER BY a, n) AS id_musica,
    'Faixa '  || LPAD(n::TEXT, 2, '0') || ' - Album ' || LPAD(a::TEXT, 4, '0')      AS nome_musica,
    'track_'  || LPAD(a::TEXT, 4, '0') || '_' || LPAD(n::TEXT, 2, '0') || '.mp3'    AS faixa_audio_url,
    (n % 3 = 0)                             AS eh_explicita,
    (ARRAY['C','C#','D','D#','E','F','F#','G','G#','A','A#','B',
           'Cm','Dm','Em','Fm','Gm','Am','Bm'])[ (a*n % 19) + 1 ]                   AS registro_tom,
    120 + (a * 7 + n * 13) % 241            AS duracao,   -- 120‒360 s
    a                                       AS id_album
FROM
    generate_series(7, 1406) AS a,     -- 1400 álbuns
    generate_series(1, 20) AS n;     -- 20 faixas por álbum  → 2800 músicas

-- ---------------------------------------------------------------
-- 6. MAPEAMENTO ARTISTA → MÚSICA
--    Cada artista é cantor de todas as músicas de seus álbuns
-- ---------------------------------------------------------------

INSERT INTO Artista_Musica (id_artista, id_musica, papel_artista)
SELECT
    aa.id_artista,
    m.id_musica,
    'cantor'
FROM Artista_Album aa
JOIN Musica m ON m.id_album = aa.id_album
WHERE m.id_musica >= 18
  AND aa.id_artista BETWEEN 1 AND 40
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------
-- 7. GÊNERO POR MÚSICA (Musica_Genero)
--    Distribui os 7 gêneros entre todas as músicas novas de forma cíclica
-- ---------------------------------------------------------------

INSERT INTO Musica_Genero (id_musica, id_genero)
SELECT
    id_musica,
    (id_musica % 7) + 1     AS id_genero
FROM Musica
WHERE id_musica >= 18
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------
-- 8. REGISTROS DE ESCUTA EM MASSA (~20 000 linhas)
--    Ouvintes 1–3, 9–10 + 41–90  ×  músicas 1–~4500
--    Usa generate_series com módulo para cruzar ouvintes × músicas
-- ---------------------------------------------------------------

INSERT INTO Ouvinte_Escuta_Musica (id_ouvinte, id_musica)
SELECT
    -- seleciona um dos 5000 ouvintes novos
    41 + ((gs * 2017) % 5000)                          AS id_ouvinte,
    -- seleciona uma das ~28 000 músicas novas
    18 + ((gs * 9973 + gs / 1000 * 4513) % 28000)   AS id_musica
FROM generate_series(1, 100000) AS gs;
-- Nota: não usamos ON CONFLICT porque id_registro é SERIAL e
-- a tabela permite múltiplas escutas da mesma música pelo mesmo ouvinte.

-- ==============================================================
--  FIM DO SCRIPT
--  Após rodar, verifique os volumes com:
--
 SELECT 'Usuário'           AS tabela,  COUNT(*) FROM usuario
 UNION ALL  
 SELECT 'Artista',                      COUNT(*) FROM artista
 UNION ALL  
 SELECT 'Ouvinte',                      COUNT(*) FROM ouvinte
 UNION ALL  
 SELECT 'Album',                        COUNT(*) FROM album
 UNION ALL
 SELECT 'Música',                       COUNT(*) FROM musica
 UNION ALL
 SELECT 'Artista_Musica',               COUNT(*) FROM Artista_Musica
 UNION ALL
 SELECT 'Ouvinte_Escuta_Musica',        COUNT(*) FROM Ouvinte_Escuta_Musica
 UNION ALL
 SELECT 'Musica_Genero',                COUNT(*) FROM Musica_Genero;
-- ==============================================================
