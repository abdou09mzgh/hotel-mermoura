document.addEventListener('DOMContentLoaded', () => {
    const data = JSON.parse(localStorage.getItem('hotelBooking'));

    if (!data) {
        document.getElementById('confirmationDetails').innerText = 'No reservation data found.';
        return;
    }

    const pricePerPerson = 2000;
    data.price = parseInt(data.guests) * pricePerPerson;

    const container = document.getElementById('confirmationDetails');
    container.innerHTML = `
        <p><strong>Arrival:</strong> ${data.arrival}</p>
        <p><strong>Name:</strong> ${data.firstName} ${data.lastName}</p>
        <p><strong>Email:</strong> ${data.email}</p>
        <p><strong>Phone:</strong> ${data.phone}</p>
        <p><strong>Guests:</strong> ${data.guests}</p>
        <p><strong>Kitchen:</strong> ${data.kitchenType}</p>
        <p><strong>Payment:</strong> ${data.paymentMethod}</p>
        <p><strong>Total Price:</strong> ${data.price} DZD</p>
    `;

    document.getElementById('downloadBtn').addEventListener('click', () => {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.text('Reservation Confirmation', 10, 10);
        doc.text(`Name: ${data.firstName} ${data.lastName}`, 10, 30);
        doc.text(`Email: ${data.email}`, 10, 40);
        doc.text(`Phone: ${data.phone}`, 10, 50);
        doc.text(`Arrival: ${data.arrival}`, 10, 60);
        doc.text(`Guests: ${data.guests}`, 10, 70);
        doc.text(`Kitchen: ${data.kitchenType}`, 10, 80);
        doc.text(`Payment: ${data.paymentMethod}`, 10, 90);
        doc.text(`Price: ${data.price} DZD`, 10, 100);

        doc.save('reservation_confirmation.pdf');
    });
});
