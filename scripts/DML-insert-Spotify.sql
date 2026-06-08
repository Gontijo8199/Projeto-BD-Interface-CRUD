INSERT INTO Plano (id_plano, nome_plano, custo_mensal) VALUES
(1000, 'gratuito',  0.00),
(1001, 'estudante', 11.00),
(1002, 'premium',   20.00),
(1003, 'duo',       18.00),
(1004, 'familia',   38.00);

INSERT INTO Beneficio (id_beneficio, nome_beneficio, descricao) VALUES
(1, 'baixar música', 'permite que o ouvinte ouça offline'),
(2, 'pular música', 'permite que o ouvinte pule quantas músicas quiser'),
(3, 'sem anúncio', 'permite que o ouvinte não veja anúncios'),
(4, 'recomendações personalizadas', 'fornece ao ouvinte recomendações baseadas no algoritmo'),
(5, 'mixar playlist', 'permite o usuário remixar transições na playlist');

INSERT INTO Plano_Beneficio (id_plano, id_beneficio) VALUES
(1001, 1),
(1001, 2),
(1002, 1),
(1002, 2),
(1002, 3),
(1002, 4),
(1002, 5);

INSERT INTO Usuario (id_usuario, foto_perfil, nome, telefone, email, tipo) VALUES
(1, 'fotonina.jpg', 'ninotica', '(31) 989571208', 'ninaleaof@gmail.com', 'Ouvinte'),
(2, 'fotoruda.png', 'rudadantas123', '(31) 989239808', 'rudazinhogameplay@hotmail.com', 'Ouvinte'),
(3, 'fotogontijo.jpg', 'rafaelgontijo', '(31) 999571205', 'rafaelgontijodasilva@outlook.com', 'Ouvinte'),
(4, 'fotodavileao.png', 'davileaof', '(31) 987953287', 'davileaof@gmail.com', 'Artista'),
(5, 'fototaylorswift.jpg', 'officialtaylorswift', '(88) 999900001', 'taylorswiftprincesinhadojacob@yahoo.com', 'Artista'),
(6, 'tylerthecreator.jpg', 'tylerthecreator', '(88) 999900011', 'tylertheman@gmail.com', 'Artista'),
(7, 'arthurverocai.jpg', 'arthurverocai', '(21) 955555544', 'arthurverocai19XX@gmail.com', 'Artista'),
(8, 'manobrown.jpg', 'manobrown', '(21) 955552156', 'manobrown@jow.com', 'Artista'),
(9, 'joao.jpg', 'joaozinho2', '(23) 9855123124', 'joaozinho123@gmail.com', 'Ouvinte'),
(10, 'maria.jpg', 'maria_f', '(31) 985632145', 'maria_f@gmail.com', 'Ouvinte');

INSERT INTO Ouvinte (id_usuario, id_plano, forma_pagamento) VALUES
(1, 1002, 'Cartão de Crédito'),
(2, 1001, 'Boleto'),
(3, 1002, 'Pix'),
(9, 1001, 'Boleto'),
(10, 1001, 'Cartão de Crédito');

INSERT INTO Artista (id_usuario, n_ouvintes, biografia, agenda_show) VALUES
(4, 2000, 'Um jovem belo-horizontino com um violão e um sonho', 'Próximo show: 15/08 no Cine Brasil'),
(5, 10000000, 'A young, free, independent woman who uses her private jet to go to the nearest grocery store', 'Next tour: this summer, on USA only!'),
(6, 3000000, 'Felicia the goat', 'Next tour: LA'),
(7, 2123413, 'Em memória de arthur verocai', '--'),
(8, 9882489, 'Esquenta não truta', 'Próximo show: 18/9 no Circo Voador');

INSERT INTO Genero (id_genero, descricao, nome_genero) VALUES
(1, 'Descrição rock', 'Rock'),
(2, 'Descrição mpb', 'Mpb'),
(3, 'Descrição pop', 'Pop'),
(4, 'Descrição rap', 'Rap'),
(5, 'Descrição boombap', 'Boombap'),
(6, 'Descrição pop-rock', 'Pop-rock'),
(7, 'Descrição metal', 'Metal');

INSERT INTO Album (id_album, tipo_album, capa, nome_album, data_lancamento) VALUES
(1, 'Single', 'gostoraro.png', 'Gosto Raro', 2023),
(2, 'EP', 'villarica.png', 'Villa Rica', 2024),
(3, 'LP', 'pontodepartida.png', 'Ponto de Partida', 2025),
(4, 'EP', 'image.jpg', '1989', 2014),
(5, 'LP', 'image(01).jpg', 'Red', 2012),
(6, 'LP', 'outrojovem.png', 'Outro Jovem Sem Noção', 2018);

INSERT INTO Musica (id_musica, nome_musica, faixa_audio_url, eh_explicita, registro_tom, duracao, id_album) VALUES
(1, 'Villa Rica', 'villarica.mp3', FALSE, 'A', 150, 2),
(2, 'A Praça', 'apraca.mp3', FALSE, 'E',  165, 2),
(3, 'Metacanção', 'metacancao.mp3', TRUE,  'Bm', 75, 2),
(4, '22', '22.mp3', TRUE,  'A#', 270, 5),
(5, 'All Too Well', 'alltoowell.mp3', FALSE, 'Em', 200, 5),
(6, 'Blank Space', 'blankspace.mp3', FALSE, 'Gm', 322, 4),
(7, 'Wildest Dreams', 'wildestdreams.mp3', FALSE, 'F', 230, 4),
(8, 'Shake It Off', 'shakeitoff.mp3', TRUE,  'F#', 220, 4),
(9, 'Gosto Raro', 'gostoraro.mp3', FALSE, 'B',  190, 1),
(10, 'Espelho de Anil', 'espelhodeanil.mp3', TRUE, 'Gm', 190, 3),
(11, 'Teatro do Absurdo', 'teatrodoabsurdo.mp3', TRUE, 'C', 255, 3),
(12, 'Domingo', 'domingo.mp3', FALSE, 'Cm',  80, 3),
(13, 'Mergulho de Paletó','mergulhodepaleto.mp3', FALSE, 'G', 119, 3),
(14, 'Ultimamente', 'ultimamente.mp3', TRUE, 'D', 164, 3),
(15, 'Karina', 'karina.mp3', FALSE, 'A', 260, 3),
(16, 'Caboclo', 'caboclo.mp3', FALSE, 'E', 170, 3),
(17, 'Dedicada a Ela', 'dedicadaaela.mp3', FALSE, 'F',  192, 3);

INSERT INTO Playlist (id_playlist, nome_playlist, descricao, eh_privada, capa_playlist, id_criador) VALUES
(1, 'Playlist 1', 'Descrição 1', FALSE, 'capa1.png', 1),
(2, 'Playlist 2', 'Descrição 2', FALSE, 'capa2.png', 2),
(3, 'Playlist 3', 'Descrição 3', TRUE, 'capa3.png', 2),
(4, 'Playlist 4', 'Descrição 4', FALSE, 'capa4.png', 3),
(5, 'Playlist 5', 'Descrição 5', TRUE, 'capa5.png', 5);

INSERT INTO Gen_Sub_Gen (id_genero, id_subgenero) VALUES
(4, 5),
(1, 6),
(3, 6),
(1, 7),
(3, 2);

INSERT INTO Artista_Album (id_artista, id_album) VALUES
(4, 1),
(4, 2),
(4, 3),
(4, 6),
(5, 4),
(5, 5);

INSERT INTO Artista_Musica (id_artista, id_musica, papel_artista) VALUES
(4, 1, 'cantor'),
(4, 2, 'cantor'),
(4, 3, 'cantor'),
(5, 4, 'cantor'),
(5, 5, 'cantor'),
(5, 6, 'cantor'),
(5, 7, 'cantor'),
(5, 8, 'cantor'),
(4, 9, 'cantor'),
(4, 10, 'cantor'),
(4, 11, 'cantor'),
(4, 12, 'cantor'),
(4, 13, 'cantor'),
(4, 14, 'cantor'),
(4, 15, 'cantor'),
(4, 16, 'cantor'),
(4, 17, 'cantor');

INSERT INTO Musica_Genero (id_musica, id_genero) VALUES
(1, 2), (2, 2), (3, 2), (4, 3), (5, 2), (6, 3), (7, 3), (8, 3),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2), (16, 2), (17, 2);

INSERT INTO Playlist_Musica (id_playlist, id_musica, ordem_na_playlist) VALUES
(1, 2, 1),
(2, 4, 1),
(3, 5, 1),
(1, 16, 2),
(1, 7, 3),
(1, 8, 4),
(2, 6, 2),
(2, 7, 3),
(2, 11, 4),
(2, 13, 5),
(3, 9, 2),
(3, 1, 3),
(3, 3, 4);

INSERT INTO Usuario_Favorita_Album (id_usuario, id_album) VALUES
(1, 1),
(2, 4),
(3, 2),
(2, 5),
(1, 6),
(2, 6);

INSERT INTO Usuario_Favorita_Playlist (id_playlist, id_usuario) VALUES
(1, 2),
(2, 1),
(3, 1),
(2, 3),
(3, 3);

INSERT INTO Ouvinte_Escuta_Musica (id_ouvinte, id_musica) VALUES
(1, 1),
(2, 3),
(3, 17),
(2, 14),
(3, 9),
(2, 10),
(3, 7),
(1, 7),
(3, 8),
(1, 15);

INSERT INTO Usuario_Segue_Usuario (id_seguidor, id_usuario) VALUES
(1, 4),
(2, 3),
(5, 4),
(4, 1),
(3, 4);