document.addEventListener('DOMContentLoaded', () => {
    const data = JSON.parse(localStorage.getItem('hotelBooking'));

    const container = document.getElementById('confirmationDetails');
    const downloadBtn = document.getElementById('downloadBtn');

    if (!data) {
        container.innerText = 'Aucune donnée de réservation trouvée.';
        if (downloadBtn) downloadBtn.style.display = 'none';
        return;
    }

    const {
        arrival,
        firstName,
        lastName,
        email,
        phone,
        guests,
        salletype,
        paymentMethod,
        price
    } = data;

    container.innerHTML = `
        <p><strong>Date d'arrivée:</strong> ${arrival}</p>
        <p><strong>Nom:</strong> ${firstName} ${lastName}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Téléphone:</strong> ${phone}</p>
        <p><strong>Nombre de personnes:</strong> ${guests}</p>
        <p><strong>Type de salle:</strong> ${salletype}</p>
        <p><strong>Mode de paiement:</strong> ${paymentMethod}</p>
        <p><strong>Prix total:</strong> ${price} DZD</p>
    `;

    if (downloadBtn) {
        downloadBtn.addEventListener('click', () => {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            let y = 10;
            doc.setFontSize(14);
            doc.text('Confirmation de Réservation - Hôtel Mermoura', 10, y);
            y += 20;

            doc.setFontSize(12);
            doc.text(`Nom: ${firstName} ${lastName}`, 10, y); y += 10;
            doc.text(`Email: ${email}`, 10, y); y += 10;
            doc.text(`Téléphone: ${phone}`, 10, y); y += 10;
            doc.text(`Date d'arrivée: ${arrival}`, 10, y); y += 10;
            doc.text(`Nombre de personnes: ${guests}`, 10, y); y += 10;
            doc.text(`Type de salle: ${salletype}`, 10, y); y += 10;
            doc.text(`Paiement: ${paymentMethod}`, 10, y); y += 10;
            doc.text(`Montant total: ${price} DZD`, 10, y); y += 10;

            doc.save('confirmation_reservation.pdf');
        });
    }
});
