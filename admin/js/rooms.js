const roomTableBody = document.querySelector('.rooms-table tbody');
const addRoomBtn = document.getElementById('addRoomBtn');
const modal = document.getElementById('roomModal');
const cancelBtn = document.getElementById('cancelRoomBtn');
const closeModal = document.getElementById('closeModal');
const roomForm = document.getElementById('roomForm');
const paginationBtns = document.querySelectorAll('.btn-pagination');

let currentPage = 1;
const limit = 5;

function loadRooms(page = 1) {
    fetch(`php/get_rooms.php?page=${page}&limit=${limit}`)
        .then(res => res.json())
        .then(data => {
            roomTableBody.innerHTML = "";
            data.forEach(room => {
                roomTableBody.innerHTML += `
    <tr>
        <td>${room.room_id}</td>
        <td>${room.nom_type}</td>
        <td>${room.Prix} DZD</td>
        <td><span class="status ${room.statut.toLowerCase()}">${room.statut}</span></td>
        <td class="actions">
            <button class="btn-delete"><i class="fas fa-trash"></i></button>
        </td>
    </tr>`;

            });
        });
}

paginationBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        if (btn.disabled || btn.classList.contains('active')) return;

        if (btn.innerText === '«') currentPage--;
        else if (btn.innerText === '»') currentPage++;
        else currentPage = parseInt(btn.innerText);

        paginationBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        loadRooms(currentPage);
    });
});

addRoomBtn.addEventListener('click', () => {
    modal.style.display = 'block';
});

cancelBtn.addEventListener('click', () => {
    modal.style.display = 'none';
    roomForm.reset();
});

closeModal.addEventListener('click', () => {
    modal.style.display = 'none';
    roomForm.reset();
});

roomForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const formData = {
        roomType: document.getElementById('roomType').value,
        roomNumber: document.getElementById('roomNumber').value,
        price: parseFloat(document.getElementById('price').value),
        size: parseInt(document.getElementById('size').value),
        capacity: parseInt(document.getElementById('capacity').value),
        availability: document.getElementById('availability').value
    };

    fetch('../php/add_room.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                modal.style.display = 'none';
                roomForm.reset();
                loadRooms(currentPage);
            }
        });
});

loadRooms(currentPage);

const btn2 = document.querySelector('.user-profile');

if (btn2) {
    btn2.onclick = function () {
    window.location.href = 'settings.html#user-settings-section';
    };
}