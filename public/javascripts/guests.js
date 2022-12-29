var renderGuests = function() {
    var guests_data = document.getElementById("guests_data");
    var container = document.getElementById("mapping");
    container.innerHTML = "<tr>" +
        "    <th>Name</th>" +
        "    <th>Group</th>" +
        "    <th>Relationship</th>" +
        "    <th>Going</th>" +
        "    <th></th>" +
        "</tr>";
    JSON.parse(guests_data.value).forEach(function(guest, index) {
        container.innerHTML += `<tr>
                                <td>${guest.name}</td>
                                <td>${guest.group}</td>
                                <td>${guest.relationship}</td>
                                <td>${guest.additional}</td>
                                <td>${guest.going}</td>
                                <td><button type="button" class="btn btn-secondary remove" onclick="removeRow(${index})">-</button></td>
                            </tr>`;
    });
};

var addRow = function() {
    var name = document.getElementById("name");
    var group = document.getElementById("group");
    var relationship = document.getElementById("relationship");
    var additional = document.getElementById("additional");
    var going = document.getElementById("going");

    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    guests_json.push({ name: name.value, group: group.value, relationship: relationship.value, additional: additional.value, going: going.value });
    guests_data.value = JSON.stringify(guests_json);

    name.value = "";
    group.selectedIndex = 0;
    relationship.selectedIndex = 0;
    additional.selectedIndex = 0;
    going.selectedIndex = 0;
    renderGuests();
};

var removeRow = function(index) {
    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    guests_json.splice(index, 1);
    guests_data.value = JSON.stringify(guests_json);
    renderGuests();
};
