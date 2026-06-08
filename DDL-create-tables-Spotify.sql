-- Instruções de uso
-- CREATE DATABASE Spotify (caso não exista)
-- \c Spotify e execute com \i DDL-create-tables-Spotify.sql

CREATE TABLE Plano (
    id_plano INT NOT NULL,
    nome_plano VARCHAR(50) NOT NULL,
    custo_mensal DECIMAL(5, 2) NOT NULL,
    CONSTRAINT PK_Plano PRIMARY KEY (id_plano)
);

CREATE TABLE Beneficio (
    id_beneficio INT NOT NULL,
    nome_beneficio VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    CONSTRAINT PK_Beneficio PRIMARY KEY (id_beneficio)
);

CREATE TABLE Usuario (
    id_usuario INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    foto_perfil VARCHAR(255),
    telefone VARCHAR(30),
    email VARCHAR(100),
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('Ouvinte', 'Artista')),
    CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE Ouvinte (
    id_usuario INT NOT NULL,
    id_plano INT NOT NULL,
    forma_pagamento VARCHAR(50),
    CONSTRAINT PK_Ouvinte PRIMARY KEY (id_usuario),
    CONSTRAINT FK_Ouvinte_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_Ouvinte_Plano FOREIGN KEY (id_plano) REFERENCES Plano (id_plano)
);

CREATE TABLE Artista (
    id_usuario INT NOT NULL,
    n_ouvintes INT DEFAULT 0,
    biografia TEXT,
    agenda_show TEXT,
    CONSTRAINT PK_Artista PRIMARY KEY (id_usuario),
    CONSTRAINT FK_Artista_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario) ON DELETE CASCADE
);

CREATE TABLE Genero (
    id_genero INT NOT NULL,
    nome_genero VARCHAR(50) NOT NULL,
    descricao VARCHAR(255),
    CONSTRAINT PK_Genero PRIMARY KEY (id_genero)
);

CREATE TABLE Album (
    id_album INT NOT NULL,
    nome_album VARCHAR(100) NOT NULL,
    capa VARCHAR(255),
    tipo_album VARCHAR(30),
    data_lancamento INT, 
    CONSTRAINT PK_Album PRIMARY KEY (id_album)
);

CREATE TABLE Musica (
    id_musica INT NOT NULL,
    nome_musica VARCHAR(100) NOT NULL,
    faixa_audio_url VARCHAR(255) NOT NULL,
    eh_explicita BOOLEAN DEFAULT FALSE,
    registro_tom VARCHAR(10),
    duracao INT, -- duração em segundos
    id_album INT NOT NULL,
    CONSTRAINT PK_Musica PRIMARY KEY (id_musica),
    CONSTRAINT FK_Musica_Album FOREIGN KEY (id_album) REFERENCES Album (id_album) ON DELETE CASCADE
);

CREATE TABLE Playlist (
    id_playlist INT NOT NULL,
    nome_playlist VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    eh_privada BOOLEAN DEFAULT FALSE,
    capa_playlist VARCHAR(255),
    id_criador INT NOT NULL,
    CONSTRAINT PK_Playlist PRIMARY KEY (id_playlist),
    CONSTRAINT FK_Playlist_Criador FOREIGN KEY (id_criador) REFERENCES Usuario (id_usuario) ON DELETE CASCADE
);

CREATE TABLE Gen_Sub_Gen (
    id_genero INT NOT NULL,
    id_subgenero INT NOT NULL,
    CONSTRAINT PK_Gen_Sub_Gen PRIMARY KEY (id_genero, id_subgenero),
    CONSTRAINT FK_GSG_Genero FOREIGN KEY (id_genero) REFERENCES Genero (id_genero) ON DELETE CASCADE,
    CONSTRAINT FK_GSG_Subgenero FOREIGN KEY (id_subgenero) REFERENCES Genero (id_genero) ON DELETE CASCADE
);

CREATE TABLE Plano_Beneficio (
    id_plano INT NOT NULL,
    id_beneficio INT NOT NULL,
    CONSTRAINT PK_Plano_Beneficio PRIMARY KEY (id_plano, id_beneficio),
    CONSTRAINT FK_PB_Plano FOREIGN KEY (id_plano) REFERENCES Plano (id_plano) ON DELETE CASCADE,
    CONSTRAINT FK_PB_Beneficio FOREIGN KEY (id_beneficio) REFERENCES Beneficio (id_beneficio) ON DELETE CASCADE
);

CREATE TABLE Artista_Album (
    id_artista INT NOT NULL,
    id_album INT NOT NULL,
    CONSTRAINT PK_Artista_Album PRIMARY KEY (id_artista, id_album),
    CONSTRAINT FK_AA_Artista FOREIGN KEY (id_artista) REFERENCES Artista (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_AA_Album FOREIGN KEY (id_album) REFERENCES Album (id_album) ON DELETE CASCADE
);

CREATE TABLE Artista_Musica (
    id_artista INT NOT NULL,
    id_musica INT NOT NULL,
    papel_artista VARCHAR(50),
    CONSTRAINT PK_Artista_Musica PRIMARY KEY (id_artista, id_musica),
    CONSTRAINT FK_AM_Artista FOREIGN KEY (id_artista) REFERENCES Artista (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_AM_Musica FOREIGN KEY (id_musica) REFERENCES Musica (id_musica) ON DELETE CASCADE
);

CREATE TABLE Ouvinte_Escuta_Musica (
    id_registro SERIAL, 
    id_ouvinte INT NOT NULL,
    id_musica INT NOT NULL,
    CONSTRAINT PK_Ouvinte_Escuta PRIMARY KEY (id_registro),
    CONSTRAINT FK_OEM_Ouvinte FOREIGN KEY (id_ouvinte) REFERENCES Ouvinte (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_OEM_Musica FOREIGN KEY (id_musica) REFERENCES Musica (id_musica) ON DELETE CASCADE
);

CREATE TABLE Musica_Genero (
    id_musica INT NOT NULL,
    id_genero INT NOT NULL,
    CONSTRAINT PK_Musica_Genero PRIMARY KEY (id_musica, id_genero),
    CONSTRAINT FK_MG_Musica FOREIGN KEY (id_musica) REFERENCES Musica (id_musica) ON DELETE CASCADE,
    CONSTRAINT FK_MG_Genero FOREIGN KEY (id_genero) REFERENCES Genero (id_genero) ON DELETE CASCADE
);

CREATE TABLE Playlist_Musica (
    id_playlist INT NOT NULL,
    id_musica INT NOT NULL,
    ordem_na_playlist INT NOT NULL,
    CONSTRAINT PK_Playlist_Musica PRIMARY KEY (id_playlist, id_musica),
    CONSTRAINT FK_PM_Playlist FOREIGN KEY (id_playlist) REFERENCES Playlist (id_playlist) ON DELETE CASCADE,
    CONSTRAINT FK_PM_Musica FOREIGN KEY (id_musica) REFERENCES Musica (id_musica) ON DELETE CASCADE
);

CREATE TABLE Usuario_Favorita_Album (
    id_usuario INT NOT NULL,
    id_album INT NOT NULL,
    CONSTRAINT PK_Usuario_Favorita_Album PRIMARY KEY (id_usuario, id_album),
    CONSTRAINT FK_UFA_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_UFA_Album FOREIGN KEY (id_album) REFERENCES Album (id_album) ON DELETE CASCADE
);

CREATE TABLE Usuario_Favorita_Playlist (
    id_playlist INT NOT NULL,
    id_usuario INT NOT NULL,
    CONSTRAINT PK_Usuario_Favorita_Playlist PRIMARY KEY (id_playlist, id_usuario),
    CONSTRAINT FK_UFP_Playlist FOREIGN KEY (id_playlist) REFERENCES Playlist (id_playlist) ON DELETE CASCADE,
    CONSTRAINT FK_UFP_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario) ON DELETE CASCADE
);

CREATE TABLE Usuario_Segue_Usuario (
    id_seguidor INT NOT NULL,
    id_usuario INT NOT NULL,
    CONSTRAINT PK_Usuario_Segue_Usuario PRIMARY KEY (id_seguidor, id_usuario),
    CONSTRAINT FK_USU_Seguidor FOREIGN KEY (id_seguidor) REFERENCES Usuario (id_usuario) ON DELETE CASCADE,
    CONSTRAINT FK_USU_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario) ON DELETE CASCADE
);