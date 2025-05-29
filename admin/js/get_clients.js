document.addEventListener("DOMContentLoaded", () => {
    fetch("php/get_clients.php")
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok");
            return response.json();
        })
        .then(data => {
            fillTable(data.chambre, ".clients-chambre-table", ["id_Client", "full_name", "Email_Client", "Phone_Client", "nom_chambre", "Date_Arive", "Date_Depart"]);
            fillTable(data.restaurant, ".clients-restaurant-table", ["id_Client", "full_name", "Email_Client", "Phone_Client", "id_Restaurant", "cuisine", "Date_Arive"]);
            fillTable(data.salle, ".clients-salle-table", ["id_Client", "full_name", "Email_Client", "Phone_Client", "id_Salle", "Type_evenement", "Date_Arive"]);
        })
        .catch(error => {
            console.error("Erreur lors du chargement des données :", error);
        });
});

function fillTable(data, tableSelector, fields) {
    const tbody = document.querySelector(`${tableSelector} tbody`);
    tbody.innerHTML = "";

    data.forEach(item => {
        const row = document.createElement("tr");
        row.innerHTML = fields.map(field => `<td>${item[field] ?? ""}</td>`).join("");
        tbody.appendChild(row);
    });
}
