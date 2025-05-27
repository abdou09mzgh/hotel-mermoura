document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('clientForm');

    form.addEventListener('submit', async function (e) {
        e.preventDefault();

        const bookingData = {
            arrival: document.getElementById('arrival').value,
            kitchenType: document.getElementById('kitchen-type').value,
            guests: parseInt(document.getElementById('guests').value, 10),
            firstName: document.getElementById('first-name').value.trim(),
            lastName: document.getElementById('last-name').value.trim(),
            email: document.getElementById('email').value.trim(),
            phone: document.getElementById('phone').value.trim(),
            paymentMethod: document.querySelector('input[name="payment"]:checked')?.value || ''
        };

        const missing = Object.entries(bookingData).find(([_, value]) => !value && value !== 0);
        if (missing) {
            alert(`Le champ ${missing[0]} est requis`);
            return;
        }

        try {
            const response = await fetch('BookRes.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(bookingData)
            });

            const result = await response.json();

            if (result.success) {
                bookingData.price = result.price;
                localStorage.setItem('hotelBooking', JSON.stringify(bookingData));

                const redirectPage = bookingData.paymentMethod === 'online'
                    ? '../dahabiya.html?id=' + result.reservationId
                    : '../confirmation/confirmationRes.html?id=' + result.reservationId;

                window.location.href = redirectPage;
            } else {
                alert('Erreur: ' + result.message);
            }
        } catch (error) {
            console.error(error);
            alert('Erreur réseau ou serveur');
        }
    });
});
