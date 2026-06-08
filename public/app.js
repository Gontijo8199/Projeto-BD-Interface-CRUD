function mudarAba(aba) {
  document.querySelectorAll('.secao').forEach(s => s.classList.remove('active'));
  document.querySelectorAll('.nav-tabs button').forEach(b => b.classList.remove('active'));
  
  if (aba === 'user') { 
    document.getElementById('secUser').classList.add('active'); 
    document.getElementById('tabUser').classList.add('active'); 
    carregarUsuarios(); 
  }
  if (aba === 'album') { 
    document.getElementById('secAlbum').classList.add('active'); 
    document.getElementById('tabAlbum').classList.add('active'); 
    carregarAlbuns(); 
  }
  if (aba === 'musica') { 
    document.getElementById('secMusica').classList.add('active'); 
    document.getElementById('tabMusica').classList.add('active'); 
    carregarMusicas(); 
    carregarSelects('musica'); 
  }
  if (aba === 'play') { 
    document.getElementById('secPlay').classList.add('active'); 
    document.getElementById('tabPlay').classList.add('active'); 
    carregarPlaylists(); 
    carregarSelects('play'); 
  }
}

async function carregarSelects(tipo, valorSelecionado = null) {
  try {
    if (tipo === 'musica') {
      const res = await fetch('/api/albuns');
      const albuns = await res.json();
      const select = document.getElementById('musicaAlbumId');
      select.innerHTML = albuns.map(a => `<option value="${a.id_album}">${a.nome_album} (ID: ${a.id_album})</option>`).join('');
      if (valorSelecionado) select.value = valorSelecionado;
    }
    if (tipo === 'play') {
      const res = await fetch('/api/usuarios');
      const users = await res.json();
      const select = document.getElementById('playCriadorId');
      select.innerHTML = users.map(u => `<option value="${u.id_usuario}">${u.nome} (ID: ${u.id_usuario})</option>`).join('');
      if (valorSelecionado) select.value = valorSelecionado;
    }
  } catch (err) {
    console.error("Erro ao carregar seletores:", err);
  }
}

async function salvar(endpoint, camposIds, callbackSucesso) {
  const corpo = {};
  const chavesDaApi = {
    userId: 'id_usuario', userNome: 'nome', userEmail: 'email', userTelefone: 'telefone', userTipo: 'tipo',
    albumId: 'id_album', albumNome: 'nome_album', albumTipo: 'tipo_album', albumAno: 'data_lancamento',
    musicaId: 'id_musica', musicaNome: 'nome_musica', musicaUrl: 'faixa_audio_url', musicaDuracao: 'duracao', musicaAlbumId: 'id_album',
    playId: 'id_playlist', playNome: 'nome_playlist', playDesc: 'descricao', playCriadorId: 'id_criador'
  };

  const campoIdChavePrimaria = camposIds[0];
  const inputChave = document.getElementById(campoIdChavePrimaria);
  const modoUpdate = inputChave.disabled;

  for (let id of camposIds) {
    const val = document.getElementById(id).value;
    if (!val && id !== 'playDesc') { 
      alert('Por favor, preencha todos os campos obrigatórios!'); 
      return; 
    }
    corpo[chavesDaApi[id]] = val;
  }

  const url = modoUpdate ? `/api/${endpoint}/${corpo[chavesDaApi[campoIdChavePrimaria]]}` : `/api/${endpoint}`;
  const metodo = modoUpdate ? 'PUT' : 'POST';

  try {
    const res = await fetch(url, {
      method: metodo,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(corpo)
    });
    
    const data = await res.json();
    if (data.error) {
      alert('Erro de Banco: ' + data.error);
    } else {
      alert(modoUpdate ? 'Registro atualizado com sucesso!' : 'Registro inserido com sucesso!');
      camposIds.forEach(id => document.getElementById(id).value = '');
      inputChave.disabled = false;

      const btnId = campoIdChavePrimaria.startsWith('user') ? 'btnUser' : campoIdChavePrimaria.startsWith('album') ? 'btnAlbum' : campoIdChavePrimaria.startsWith('musica') ? 'btnMusica' : 'btnPlay';
      const textoPadrao = campoIdChavePrimaria.startsWith('user') ? 'Salvar Usuário' : campoIdChavePrimaria.startsWith('album') ? 'Salvar Álbum' : campoIdChavePrimaria.startsWith('musica') ? 'Salvar Música' : 'Salvar Playlist';
      document.getElementById(btnId).innerText = textoPadrao;

      callbackSucesso();
    }
  } catch (err) {
    alert('Erro ao processar requisição: ' + err.message);
  }
}

async function deletar(endpoint, id, callback) {
  if (confirm('Deseja remover este registro? Chaves dependentes em CASCADE também serão excluídas.')) {
    try {
      const res = await fetch(`/api/${endpoint}/${id}`, { method: 'DELETE' });
      const data = await res.json();
      if (data.error) alert('Erro do Banco: ' + data.error);
      else callback();
    } catch (err) {
      alert('Erro ao conectar ao servidor.');
    }
  }
}

async function preencherFormulario(tipo, ...valores) {
  if (tipo === 'user') {
    document.getElementById('userId').value = valores[0];
    document.getElementById('userId').disabled = true; 
    document.getElementById('userNome').value = valores[1];
    document.getElementById('userEmail').value = valores[2];
    document.getElementById('userTelefone').value = valores[3];
    document.getElementById('userTipo').value = valores[4];
    document.getElementById('btnUser').innerText = 'Atualizar Usuário';
  }
  if (tipo === 'album') {
    document.getElementById('albumId').value = valores[0];
    document.getElementById('albumId').disabled = true;
    document.getElementById('albumNome').value = valores[1];
    document.getElementById('albumTipo').value = valores[2];
    document.getElementById('albumAno').value = valores[3];
    document.getElementById('btnAlbum').innerText = 'Atualizar Álbum';
  }
  if (tipo === 'musica') {
    document.getElementById('musicaId').value = valores[0];
    document.getElementById('musicaId').disabled = true;
    document.getElementById('musicaNome').value = valores[1];
    document.getElementById('musicaUrl').value = valores[2];
    document.getElementById('musicaDuracao').value = valores[3];
    await carregarSelects('musica', valores[4]);
    document.getElementById('btnMusica').innerText = 'Atualizar Música';
  }
  if (tipo === 'play') {
    document.getElementById('playId').value = valores[0];
    document.getElementById('playId').disabled = true;
    document.getElementById('playNome').value = valores[1];
    document.getElementById('playDesc').value = valores[2];
    await carregarSelects('play', valores[3]);
    document.getElementById('btnPlay').innerText = 'Atualizar Playlist';
  }
}

async function carregarUsuarios() {
  const res = await fetch('/api/usuarios'); const dados = await res.json();
  const l = document.getElementById('listaUsuarios'); l.innerHTML = '';
  dados.forEach(u => {
    l.innerHTML += `<li>
      <b>ID ${u.id_usuario}:</b> ${u.nome} (${u.tipo})
      <button onclick="preencherFormulario('user', ${u.id_usuario}, '${u.nome}', '${u.email}', '${u.telefone}', '${u.tipo}')">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('usuarios', ${u.id_usuario}, carregarUsuarios)">Remover</button>
    </li>`;
  });
}

async function carregarAlbuns() {
  const res = await fetch('/api/albuns'); const dados = await res.json();
  const l = document.getElementById('listaAlbuns'); l.innerHTML = '';
  dados.forEach(a => {
    l.innerHTML += `<li>
      <b>ID ${a.id_album}:</b> ${a.nome_album}
      <button onclick="preencherFormulario('album', ${a.id_album}, '${a.nome_album}', '${a.tipo_album}', ${a.data_lancamento})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('albuns', ${a.id_album}, carregarAlbuns)">Remover</button>
    </li>`;
  });
}

async function carregarMusicas() {
  const res = await fetch('/api/musicas'); const dados = await res.json();
  const l = document.getElementById('listaMusicas'); l.innerHTML = '';
  dados.forEach(m => {
    l.innerHTML += `<li>
      <b>ID ${m.id_musica}:</b> ${m.nome_musica}
      <button onclick="preencherFormulario('musica', ${m.id_musica}, '${m.nome_musica}', '${m.faixa_audio_url}', ${m.duracao}, ${m.id_album})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('musicas', ${m.id_musica}, carregarMusicas)">Remover</button>
    </li>`;
  });
}

async function carregarPlaylists() {
  const res = await fetch('/api/playlists'); const dados = await res.json();
  const l = document.getElementById('listaPlaylists'); l.innerHTML = '';
  dados.forEach(p => {
    l.innerHTML += `<li>
      <b>ID ${p.id_playlist}:</b> ${p.nome_playlist}
      <button onclick="preencherFormulario('play', ${p.id_playlist}, '${p.nome_playlist}', '${p.descricao || ""}', ${p.id_criador})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('playlists', ${p.id_playlist}, carregarPlaylists)">Remover</button>
    </li>`;
  });
}

async function buscarAlbum() {
  const nome = document.getElementById('buscaAlbum').value;
  if (!nome) { carregarAlbuns(); return; }
  const res = await fetch(`/api/albuns/busca?nome=${nome}`); const dados = await res.json();
  const l = document.getElementById('listaAlbuns'); l.innerHTML = '';
  dados.forEach(a => {
    l.innerHTML += `<li><b>[FILTRO]</b> ID ${a.id_album}: ${a.nome_album}
      <button onclick="preencherFormulario('album', ${a.id_album}, '${a.nome_album}', '${a.tipo_album}', ${a.data_lancamento})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('albuns', ${a.id_album}, carregarAlbuns)">Remover</button>
    </li>`;
  });
}

async function buscarMusica() {
  const nome = document.getElementById('buscaNome').value;
  if (!nome) { carregarMusicas(); return; }
  const res = await fetch(`/api/musicas/busca?nome=${nome}`); const dados = await res.json();
  const l = document.getElementById('listaMusicas'); l.innerHTML = '';
  dados.forEach(m => {
    l.innerHTML += `<li><b>[INDEX]</b> ID ${m.id_musica}: ${m.nome_musica}
      <button onclick="preencherFormulario('musica', ${m.id_musica}, '${m.nome_musica}', '${m.faixa_audio_url}', ${m.duracao}, ${m.id_album})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('musicas', ${m.id_musica}, carregarMusicas)">Remover</button>
    </li>`;
  });
}

async function buscarPlaylist() {
  const nome = document.getElementById('buscaPlay').value;
  if (!nome) { carregarPlaylists(); return; }
  const res = await fetch(`/api/playlists/busca?nome=${nome}`); const dados = await res.json();
  const l = document.getElementById('listaPlaylists'); l.innerHTML = '';
  dados.forEach(p => {
    l.innerHTML += `<li><b>[FILTRO]</b> ID ${p.id_playlist}: ${p.nome_playlist}
      <button onclick="preencherFormulario('play', ${p.id_playlist}, '${p.nome_playlist}', '${p.descricao || ""}', ${p.id_criador})">Editar</button>
      <button style="background-color:#e74c3c" onclick="deletar('playlists', ${p.id_playlist}, carregarPlaylists)">Remover</button>
    </li>`;
  });
}

carregarUsuarios();