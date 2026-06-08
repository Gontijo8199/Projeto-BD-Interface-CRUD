# Spotify BD CRUD

## Como Executar o Projeto

1. Abra o projeto diretamente no GitHub Codespaces (o ambiente e o banco de dados serão configurados de forma automática).
2. Espere o sistema iniciar corretamente.
3. Acesse o sistema através do link gerado na porta 3000 na aba Ports.


## Otimização de Performance (Índice)



```sql
CREATE INDEX idx_musica_nome ON Musica (nome_musica);

```

<!-- TODO: Terminar -->
```sql
EXPLAIN ANALYZE SELECT * FROM Musica WHERE nome_musica = 'Nome da Faixa';
```


## Estrutura Relacional

| Tabela | Chave Primária (PK) | Chaves Estrangeiras (FK) | Operações |
| --- | --- | --- | --- |
| **Usuario** | `id_usuario` | Nenhuma | CRUD Completo |
| **Album** | `id_album` | Nenhuma | CRUD Completo + Busca |
| **Musica** | `id_musica` | `id_album` | CRUD Completo + Busca Indexada |
| **Playlist** | `id_playlist` | `id_criador` | CRUD Completo + Busca |

> **Nota de Integridade:** O banco está configurado com `ON DELETE CASCADE`. A remoção de um Usuário ou Álbum deletará automaticamente as Playlists ou Músicas vinculadas a eles.


## Tecnologias Utilizadas

* **Ambiente:** GitHub Codespaces e Docker
* **Banco de Dados:** PostgreSQL
* **Backend:** Node.js e Express.js
* **Frontend:** HTML, CSS3 e JavaScript 