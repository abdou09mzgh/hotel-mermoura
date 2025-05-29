
document.addEventListener('DOMContentLoaded', function () {
    fetch('php/get_admins.php')
        .then(response => response.json())
        .then(data => {
            const tbody = document.querySelector('.users-table tbody');
            tbody.innerHTML = '';

            data.forEach(admin => {
                const row = document.createElement('tr');

                row.innerHTML = `
                    <td>${admin.id_Admin}</td>
                    <td>${admin.FirstName}</td>
                    <td>${admin.LastName}</td>
                    <td>${admin.User_name}</td>
                `;

                tbody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Erreur lors du chargement des données admin :', error);
        });
});

