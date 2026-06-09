# Análise de Performance — Índices vs Varredura Sequencial

## Contexto

O objetivo desta análise é demonstrar o ganho de performance ao criar índices B-tree em colunas de texto frequentemente que não possuem índice por padrão. Além disso, também foi realizada uma consulta de JOIN, onde temos dois gargalos de busca sequencial.

Para isso, populamos a base com um alto volume de dados, de forma que, no momento dos testes, as tabelas sejam dos seguintes tamanhos:

| Tabela | Linhas |
|--------|-------:|
| ```musica``` | 28 017 |
| ```usuario``` | 5 040 |
| ```album``` | 1 407 |
| ```ouvinte_escuta_musica``` | 100 010 |

---

## Resultados por consulta

### 1. Busca de música pelo nome

```sql
SELECT * FROM musica WHERE nome_musica = 'Faixa 18 - Album 0224';
```

| Métrica | Sem índice | Com índice | Ganho |
|---|---|---|---|
| Tipo de varredura | `Seq Scan` | `Index Scan` | — |
| Execution Time | 2,837 ms | 0,048 ms | 59× |
| Linhas examinadas | 28 017 | 1 | 28 016× |
| Índice utilizado | — | `nome_musica_idx` | — |

---

### 2. Busca de usuário pelo nome

```sql
SELECT * FROM usuario WHERE nome = 'ouvinte_04412';
```

| Métrica | Sem índice | Com índice | Ganho |
|---|---|---|---|
| Tipo de varredura | `Seq Scan` | `Index Scan` | — |
| Execution Time | 0,443 ms | 0,029 ms | 15× |
| Linhas examinadas | 5 040 | 1 | 5 039× |
| Índice utilizado | — | `nome_usr_idx` | — |

---

### 3. Busca de álbum pelo nome

```sql
SELECT * FROM album WHERE nome_album = 'Coletânea Rock Vol. 13';
```

| Métrica | Sem índice | Com índice | Ganho |
|---|---|---|---|
| Tipo de varredura | `Seq Scan` | `Index Scan` | — |
| Execution Time | 0,119 ms | 0,021 ms | 6× |
| Linhas examinadas | 1 407 | 1 | 1 406× |
| Índice utilizado | — | `nome_album_idx` | — |

---

### 4. Histórico de músicas ouvidas por um usuário (JOIN)

```sql
SELECT u.id_usuario, u.nome, m.nome_musica, a.nome_album, m.duracao
FROM usuario u
    JOIN ouvinte_escuta_musica om ON om.id_ouvinte = u.id_usuario
    JOIN musica m ON m.id_musica = om.id_musica
    JOIN album a ON a.id_album = m.id_album
WHERE u.nome = 'ouvinte_04412'
ORDER BY om.id_registro DESC LIMIT 50;
```

Esta consulta foi realizada com dois índices e avaliada no impacto de cada um.

| Métrica | Sem índice | Com índice | Ganho total |
|---|---|---|---|
| Execution Time | 11,722 ms | 0,297 ms | 39× |
| Scan em `usuario` | Seq Scan — 5 039 desc. | Index Scan — 0 desc. | — |
| Scan em `ouvinte_escuta_musica` | Seq Scan — 100 010 linhas | Bitmap Heap Scan — 20 linhas | 72× |
| Estratégia de join | Hash Join | Nested Loop | — |


---

## Tabela-resumo

| Consulta | Sem índice | Com índice | Fator de melhora | Scan sem índice | Scan com índice |
|---|---:|---:|:---:|---|---|
| `musica.nome_musica = ?` | 2,837 ms | 0,048 ms | **59×** | Seq Scan — 28 017 linhas | Index Scan — 1 linha |
| `usuario.nome = ?` | 0,443 ms | 0,029 ms | **15×** | Seq Scan — 5 040 linhas | Index Scan — 1 linha |
| `album.nome_album = ?` | 0,119 ms | 0,021 ms | **6×** | Seq Scan — 1 407 linhas | Index Scan — 1 linha |
| Histórico do usuário (JOIN) | 11,722 ms | 0,297 ms | **39×** | Seq Scan em `usuario` e `oem` | Index Scan + Bitmap Heap Scan |

---

## Interpretação geral

### Índices simples: eliminação total do Seq Scan

Nas consultas 1, 2 e 3, o índice substituiu completamente a varredura sequencial por uma navegação direta na árvore B-tree. O padrão é consistente: uma busca (`Index Searches: 1`), 2 ou 3 buffers acessados, 0 linhas descartadas. O fator de melhora é proporcional ao tamanho da tabela: `musica` com 28 017 linhas rendeu 59× e `album` com 1 407 linhas rendeu 6×.

### JOIN: a importância de indexar o gargalo certo

A consulta de histórico ilustra que indexar apenas parte do plano tem impacto limitado. Com `nome_usr_idx` sozinho, o ganho é menos impactante, porque o custo dominante consiste no Seq Scan de 100 010 linhas em `ouvinte_escuta_musica`. Somente ao adicionar `om_id_ouv_idx` em `ouvinte_escuta_musica(id_ouvinte)` o planner consegue evitar esse Seq Scan, trocando o Hash Join por um Nested Loop cirúrgico que lê apenas as 20 linhas relevantes.