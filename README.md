# Spotify BD CRUD

## Alunos
- Nina Leão Fonseca
- Rafael Gontijo Ferreira
- Rudá Dantas Ruoso Brandão

## Como Executar o Projeto

1. Abra o projeto diretamente no GitHub Codespaces (o ambiente e o banco de dados serão configurados de forma automática).
2. Espere o sistema iniciar corretamente.
3. Acesse o sistema através do link gerado na porta 3000 na aba Ports.
   
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Gontijo8199/Projeto-BD-Interface-CRUD)

## Estrutura Relacional

| Tabela | Chave Primária (PK) | Chaves Estrangeiras (FK) | Operações |
| --- | --- | --- | --- |
| **Usuario** | `id_usuario` | Nenhuma | CRUD Completo + Busca |
| **Album** | `id_album` | Nenhuma | CRUD Completo + Busca |
| **Musica** | `id_musica` | `id_album` | CRUD Completo + Busca Indexada |
| **Playlist** | `id_playlist` | `id_criador` | CRUD Completo + Busca |

> **Nota de Integridade:** O banco está configurado com `ON DELETE CASCADE`. A remoção de um Usuário ou Álbum deletará automaticamente as Playlists ou Músicas vinculadas a eles.


## Otimização de Performance (Índice)

A busca sequencial em grandes bases de dados é extremamente proibitiva devido ao alto custo computacional, portanto, para permitir análises mais elaboradas, SGBDs estabelecem um sistema de índices. Com ele o PostgreSQL pode organizar os nomes das músicas em uma estrutura de árvore balanceada ordenada. Na prática, isso transforma uma varredura sequencial lenta (que precisa ler linha por linha) em uma estratégia baseada nos princípios da Busca Binária. Em vez de percorrer todos os registros do disco, o leitor do banco consegue "cortar caminhos", descartando blocos massivos de dados que não contêm o termo procurado, reduzindo drasticamente o custo computacional e garantindo que o banco encontre qualquer faixa musical de forma quase instantânea, mesmo que o catálogo cresça para milhões de linhas.

Uma análise mais detalhada pode ser encontrada nesse [estudo de caso](entrega/analise.md), onde inflamos artificialmente o tamanho da nossa base de dados para poder avaliar a efetividade do sistema de índices. Para repetir o experimento, execute os comandos abaixo, os resultados devem aparecer no [log](entrega/index-performance.log):

```sh
sudo -u postgres psql -d spotify -f scripts/DML-populate-bulk-Spotify.sql;
sudo -u postgres psql -d spotify -f scripts/index-performance.sql > entrega/index-performance.log 2>&1;
```

## Tecnologias Utilizadas

* **Ambiente:** GitHub Codespaces e Docker
* **Banco de Dados:** PostgreSQL
* **Backend:** Node.js e Express.js
* **Frontend:** HTML, CSS3 e JavaScript 
