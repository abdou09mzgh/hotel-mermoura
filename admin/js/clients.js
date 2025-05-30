document.getElementById('clientSearch').addEventListener('input', async function () {
  const search = this.value.trim();

  if (search === '') {
    document.getElementById('clientList').innerHTML = '';
    return;
  }

  const response = await fetch('php/searchclients.php?query=' + encodeURIComponent(search));
  const clients = await response.json();

  const container = document.getElementById('clientList');
  container.innerHTML = '';

  clients.forEach(client => {
    const div = document.createElement('div');
    div.className = 'client';
    div.innerHTML = `
      <strong>${client.FName_Client} ${client.LName_Client}</strong><br>
      Téléphone: ${client.Phone_Client}<br>
      Email: ${client.Email_Client}<hr>
    `;
    container.appendChild(div);
  });
});



const btn2 = document.querySelector('.btn-add-client');

if (btn2) {
    btn2.onclick = function () {
    window.location.href = 'addclient.html';
    };
}
