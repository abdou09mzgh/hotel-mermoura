document.addEventListener('DOMContentLoaded', function () {
  const data = JSON.parse(localStorage.getItem('hotelBooking'));

  if (!data) {
    document.body.innerHTML = '<p>Aucune réservation trouvée.</p>';
    return;
  }

  const nights = Math.max(
    (new Date(data.departure) - new Date(data.arrival)) / (1000 * 60 * 60 * 24),
    1
  );

  const prices = {
    "Single": 5000,
    "Double": 8000,
    "Junior-Single": 10000,
    "Junior-Double": 12000,
    "Apart-Single": 15000,
    "Apart-Double": 18000
  };

  const roomPrice = prices[data.roomType] || 0;
  const totalPrice = nights * roomPrice;

  document.getElementById('client-name').textContent = `${data.firstName} ${data.lastName}`;
  document.getElementById('room-type').textContent = data.roomType;
  document.getElementById('arrival-date').textContent = new Date(data.arrival).toLocaleDateString('fr-FR');
  document.getElementById('departure-date').textContent = new Date(data.departure).toLocaleDateString('fr-FR');
  document.getElementById('nights-count').textContent = nights;
  document.getElementById('guests-count').textContent = data.guests;
  document.getElementById('payment-method').textContent = data.paymentMethod === 'online' ? 'Paiement en ligne' : 'Paiement à l’hôtel';
  document.getElementById('total-price').textContent = totalPrice.toLocaleString('fr-DZ') + ' DA';

  document.getElementById('download-pdf').addEventListener('click', async function () {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    const lines = [
      'Confirmation de Réservation',
      '',
      `Nom: ${data.firstName} ${data.lastName}`,
      `Type de chambre: ${data.roomType}`,
      `Date d'arrivée: ${new Date(data.arrival).toLocaleDateString('fr-FR')}`,
      `Date de départ: ${new Date(data.departure).toLocaleDateString('fr-FR')}`,
      `Nombre de nuits: ${nights}`,
      `Nombre de personnes: ${data.guests}`,
      `Méthode de paiement: ${data.paymentMethod === 'online' ? 'Paiement en ligne' : 'Paiement à l’hôtel'}`,
      `Prix total: ${totalPrice.toLocaleString('fr-DZ')} DA`
    ];

    lines.forEach((line, index) => {
      doc.text(line, 20, 20 + index * 10);
    });

    doc.save('confirmation_reservation.pdf');
  });
});
