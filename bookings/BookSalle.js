document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('clientForm');

  form.addEventListener('submit', async function (e) {
    e.preventDefault();

    const bookingData = {
      arrival: document.getElementById('arrival').value,
      typeEvenement: document.getElementById('type-evenement').value,
      guests: parseInt(document.getElementById('guests').value, 10),
      firstName: document.getElementById('first-name').value.trim(),
      lastName: document.getElementById('last-name').value.trim(),
      email: document.getElementById('email').value.trim(),
      phone: document.getElementById('phone').value.trim(),
      paymentMethod: document.querySelector('input[name="payment"]:checked')?.value || ''
    };

    if (bookingData.guests <= 0) {
      alert("Le nombre de personnes doit être supérieur à zéro.");
      return;
    }

    const missingField = Object.entries(bookingData).find(([_, value]) => !value && value !== 0);
    if (missingField) {
      alert(`Le champ ${missingField[0]} est requis.`);
      return;
    }

    try {
      const response = await fetch('BookSalle.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(bookingData)
      });

      const result = await response.json();

      if (result.success && result.reservationId) {
        bookingData.price = result.price;
        localStorage.setItem('hotelBooking', JSON.stringify(bookingData));

        if (bookingData.paymentMethod === 'online') {
          window.location.href = '../dahadiyasa.html?id=' + result.reservationId;
        } else {
          window.location.href = '../confirmation/confirmationSalle.html?id=' + result.reservationId;
        }
      } else {
        alert('Erreur: ' + result.message);
      }
    } catch (err) {
      alert('Erreur réseau ou serveur');
      console.error(err);
    }
  });
});
