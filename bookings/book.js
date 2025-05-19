document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('clientForm');

    form.addEventListener('submit', async function (e) {
        e.preventDefault();

        const bookingData = {
            arrival: document.getElementById('arrival').value,
            departure: document.getElementById('departure').value,
            roomType: document.getElementById('room-type').value,
            guests: document.getElementById('guests').value,
            firstName: document.getElementById('first-name').value.trim(),
            lastName: document.getElementById('last-name').value.trim(),
            email: document.getElementById('email').value.trim(),
            phone: document.getElementById('phone').value.trim(),
            paymentMethod: document.querySelector('input[name="payment"]:checked')?.value || ''
        };

        const missingField = Object.entries(bookingData).find(([key, value]) => !value);
        if (missingField) {
            alert(`Le champ ${missingField[0]} est requis.`);
            return;
        }

        try {
            const response = await fetch('/hotel-mermoura/bookings/book.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(bookingData)
            });

            const result = await response.json();

            if (result.success) {
                localStorage.setItem('hotelBooking', JSON.stringify(bookingData));

                if (bookingData.paymentMethod === 'online') {
                    window.location.href = '../dahabiya.html?id=' + result.reservationId;
                } else {
                    window.location.href = '../confirmation/confirmation.html?id=' + result.reservationId;
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

