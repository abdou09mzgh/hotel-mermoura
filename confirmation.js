document.addEventListener('DOMContentLoaded', function () {
    const bookingData = JSON.parse(localStorage.getItem('hotelBooking'));

    if (!bookingData) {
        alert("Aucune réservation trouvée");
        window.location.href = 'Accueil.html';
        return;
    }

    document.getElementById('confirmationDetails').innerHTML = `
        <div class="confirmation-card">
            <h2>✔ Réservation confirmée</h2>
            <div class="details">
                <p><span class="label">Arrivée:</span> ${new Date(bookingData.arrival).toLocaleDateString('fr-FR')}</p>
                <p><span class="label">Départ:</span> ${new Date(bookingData.departure).toLocaleDateString('fr-FR')}</p>
                <p><span class="label">Type de chambre:</span> ${bookingData.roomType}</p>
                <p><span class="label">Nombre de personnes:</span> ${bookingData.guests}</p>
                <p><span class="label">Prénom:</span> ${bookingData.firstName}</p>
                <p><span class="label">Nom:</span> ${bookingData.lastName}</p>
                <p><span class="label">Email:</span> ${bookingData.email}</p>
                <p><span class="label">Téléphone:</span> ${bookingData.phone}</p>
                <p><span class="label">Paiement:</span> ${bookingData.paymentMethod === 'hotel' ? 'À l\'hôtel' : 'En ligne'}</p>
            </div>
        </div>
    `;
});
