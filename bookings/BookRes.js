// Fetch all restaurants
function loadRestaurants() {
    fetch('get_restaurants.php')
      .then(res => res.json())
      .then(data => {
        const list = document.getElementById('restaurant-list');
        list.innerHTML = '';
        data.forEach(r => {
          const item = document.createElement('li');
          item.textContent = `ID: ${r.id} | Prix: ${r.Prix} | Capacité: ${r.capacite} | Statut: ${r.statut} | Food: ${r.food}`;
          list.appendChild(item);
        });
      });
  }
  
  // Submit new restaurant from form
  function submitForm(event) {
    event.preventDefault();
  
    const form = event.target;
    const formData = new FormData(form);
  
    fetch('insert_restaurant.php', {
      method: 'POST',
      body: formData
    })
      .then(res => res.text())
      .then(msg => {
        alert(msg);
        loadRestaurants();
        form.reset();
      });
  }
  