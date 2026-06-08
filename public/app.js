function mudarAba(aba) {
  document.querySelectorAll('.secao').forEach(s => s.classList.remove('active'));
  document.querySelectorAll('.nav-tabs button').forEach(b => b.classList.remove('active'));
  
  if(aba === 'user') { document.getElementById('secUser').classList.add('active'); document.getElementById('tabUser').classList.add('active'); carregarUsuarios(); }
  if(aba === 'album') { document.getElementById('secAlbum').classList.add('active'); document.getElementById('tabAlbum').classList.add('active'); carregarAlbuns(); }
  if(aba === 'musica') { document.getElementById('secMusica').classList.add('active'); document.getElementById('tabMusica').classList.add('active'); carregarMusicas(); }
  if(aba === 'play') { document.getElementById('secPlay').classList.add('active'); document.getElementById('tabPlay').classList.add('active'); carregarPlaylists(); }
}

async function salvar(endpoint, camposIds, callbackSucesso) {
  const corpo = {};
  const chavesDaApi = {
    userId: 'id_usuario', userNome: 'nome', userEmail: 'email', userTelefone: 'telefone', userTipo: 'tipo',
    albumId: 'id_album', albumNome: 'nome_album', albumTipo: 'tipo_album', albumAno: 'data_lancamento',
    musicaId: 'id_musica', musicaNome: 'nome_musica', musicaUrl: 'faixa_audio_url', musicaDuracao: 'duracao', musicaAlbumId: 'id_album',
    playId: 'id_playlist', playNome: 'nome_playlist', playDesc: 'descricao', playCriadorId: 'id_criador'
  };

  for (let id of camposIds) {
    const val = document.getElementById(id).value;
    if(!val) { alert('Preencha todos os campos da seção!'); return; }
    corpo[chavesDaApi[id]] = val;
  }

  const res = await fetch(`/api/${endpoint}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(corpo)
  });
  const data = await res.json();
  if(data.error) alert('Erro de Integridade: ' + data.error);
  else { alert('Inserido com sucesso!'); camposIds.forEach(id => document.getElementById(id).value = ''); callbackSucesso(); }
}

async function deletar(endpoint, id, callback) {
  if(confirm('Confirmar exclusão? Dependências em CASCADE sumirão.')) {
    await fetch(`/api/${endpoint}/${id}`, { method: 'DELETE' });
    callback();
  }
}


async function carregarUsuarios() {
  const res = await fetch('/api/usuarios'); const dados = await res.json();
  const l = document.getElementById('listaUsuarios'); l.innerHTML = '';
  dados.forEach(u => l.innerHTML += `<li><b>ID ${u.id_usuario}:</b> ${u.nome} (${u.tipo}) <button class="btn-acao" onclick="deletar('usuarios', ${u.id_usuario}, carregarUsuarios)">Remover</button></li>`);
}

async function carregarAlbuns() {
  const res = await fetch('/api/albuns'); const dados = await res.json();
  const l = document.getElementById('listaAlbuns'); l.innerHTML = '';
  dados.forEach(a => l.innerHTML += `<li><b>ID ${a.id_album}:</b> ${a.nome_album} (${a.data_lancamento}) <button class="btn-acao" onclick="deletar('albuns', ${a.id_album}, carregarAlbuns)">Remover</button></li>`);
}

async function carregarMusicas() {
  const res = await fetch('/api/musicas'); const dados = await res.json();
  const l = document.getElementById('listaMusicas'); l.innerHTML = '';
  dados.forEach(m => l.innerHTML += `<li><b>ID ${m.id_musica}:</b> ${m.nome_musica} <span class="info-fk">(Álbum FK: ${m.id_album})</span> <button class="btn-acao" onclick="deletar('musicas', ${m.id_musica}, carregarMusicas)">Remover</button></li>`);
}

async function carregarPlaylists() {
  const res = await fetch('/api/playlists'); const dados = await res.json();
  const l = document.getElementById('listaPlaylists'); l.innerHTML = '';
  dados.forEach(p => l.innerHTML += `<li><b>ID ${p.id_playlist}:</b> ${p.nome_playlist} <span class="info-fk">(Dono: User ${p.id_criador})</span> <button class="btn-acao" onclick="deletar('playlists', ${p.id_playlist}, carregarPlaylists)">Remover</button></li>`);
}


async function buscarMusica() {
  const nome = document.getElementById('buscaNome').value;
  const res = await fetch(`/api/musicas/busca?nome=${nome}`); const dados = await res.json();
  const l = document.getElementById('listaMusicas'); l.innerHTML = '';
  if(dados.length === 0) { l.innerHTML = '<li>Música não encontrada no índice.</li>'; return; }
  dados.forEach(m => l.innerHTML += `<li><b>[INDEX MATCH]</b> ID ${m.id_musica} - ${m.nome_musica} (Álbum FK: ${m.id_album})</li>`);
}

carregarUsuarios();