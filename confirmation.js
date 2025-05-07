// document.addEventListener('DOMContentLoaded', function () {
//     const bookingData = JSON.parse(localStorage.getItem('hotelBooking'));

//     if (!bookingData) {
//         alert("Aucune réservation trouvée");
//         window.location.href = 'Accueil.html';
//         return;
//     }

//     document.getElementById('confirmationDetails').innerHTML = `
//         <div class="confirmation-card">
//             <h2>✔ Réservation confirmée</h2>
//             <div class="details">
//                 <p><span class="label">Arrivée:</span> ${new Date(bookingData.arrival).toLocaleDateString('fr-FR')}</p>
//                 <p><span class="label">Départ:</span> ${new Date(bookingData.departure).toLocaleDateString('fr-FR')}</p>
//                 <p><span class="label">Type de chambre:</span> ${bookingData.roomType}</p>
//                 <p><span class="label">Nombre de personnes:</span> ${bookingData.guests}</p>
//                 <p><span class="label">Prénom:</span> ${bookingData.firstName}</p>
//                 <p><span class="label">Nom:</span> ${bookingData.lastName}</p>
//                 <p><span class="label">Email:</span> ${bookingData.email}</p>
//                 <p><span class="label">Téléphone:</span> ${bookingData.phone}</p>
//                 <p><span class="label">Paiement:</span> ${bookingData.paymentMethod === 'hotel' ? 'À l\'hôtel' : 'En ligne'}</p>
//             </div>
//         </div>
//     `;
// });

// document.addEventListener('DOMContentLoaded', function () {
//     const data = JSON.parse(localStorage.getItem('hotelBooking'));

//     if (!data) {
//       document.body.innerHTML = '<p>Aucune réservation trouvée.</p>';
//       return;
//     }

//     const nights = Math.max(
//       (new Date(data.departure) - new Date(data.arrival)) / (1000 * 60 * 60 * 24),
//       1
//     );

//     const prices = {
//       "Single": 5000,
//       "Double": 8000,
//       "Junior-Single": 10000,
//       "Junior-Double": 12000,
//       "Apart-Single": 15000,
//       "Apart-Double": 18000
//     };

//     const roomPrice = prices[data.roomType] || 0;
//     const totalPrice = nights * roomPrice;

//     document.getElementById('client-name').textContent = `${data.firstName} ${data.lastName}`;
//     document.getElementById('room-type').textContent = data.roomType;
//     document.getElementById('arrival-date').textContent = new Date(data.arrival).toLocaleDateString('fr-FR');
//     document.getElementById('departure-date').textContent = new Date(data.departure).toLocaleDateString('fr-FR');
//     document.getElementById('nights-count').textContent = nights;
//     document.getElementById('guests-count').textContent = data.guests;
//     document.getElementById('payment-method').textContent = data.paymentMethod === 'online' ? 'Paiement en ligne' : 'Paiement à l’hôtel';
//     document.getElementById('total-price').textContent = totalPrice.toLocaleString('fr-DZ') + ' DA';
//   });