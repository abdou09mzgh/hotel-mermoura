document.addEventListener('DOMContentLoaded', function() {
    const bookingData = JSON.parse(localStorage.getItem('hotelBooking'));

    if (!bookingData) {
        alert("Aucune réservation trouvée");
        window.location.href = '../Accueil.html';
        return;
    }

    document.getElementById('bookingDetails').innerHTML = `
        <p><strong>Arrivée:</strong> ${new Date(bookingData.arrival).toLocaleDateString('fr-FR')}</p>
        <p><strong>Départ:</strong> ${new Date(bookingData.departure).toLocaleDateString('fr-FR')}</p>
        <p><strong>Type:</strong> ${bookingData.roomType}</p>
        <p><strong>Personnes:</strong> ${bookingData.guests}</p>
    `;

    document.getElementById('clientForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        const clientData = {
            firstName: document.getElementById('first-name').value.trim(),
            lastName: document.getElementById('last-name').value.trim(),
            email: document.getElementById('email').value.trim(),
            phone: document.getElementById('phone').value.trim(),
            paymentMethod: document.getElementById('hotel').checked ? 'Payment at the hotel' : 'Online payment'
        };

        try {
            const response = await fetch('/hotel-mermoura/api/process_booking.php', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({
                    arrival: bookingData.arrival,
                    departure: bookingData.departure,
                    roomType: bookingData.roomType,
                    guests: bookingData.guests,
                    firstName: clientData.firstName,
                    lastName: clientData.lastName,
                    email: clientData.email,
                    phone: clientData.phone
                })
            });

            if (!response.ok) {
                throw new Error('Erreur serveur');
            }
            
            const result = await response.json();

            if (result.success) {
                localStorage.removeItem('hotelBooking');
                window.location.href = '../confirmation.html?id=' + result.reservationId;
            } else {
                alert("Erreur: " + result.message);
            }
        } catch (error) {
            console.error("Erreur:", error);
            alert("Erreur réseau");
        }
    });
});
