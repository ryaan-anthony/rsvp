var isSelected = function(status, expected) {
    if(status === expected){
        return 'selected';
    } else {
        return '';
    }
};

var renderGuests = function() {
    var guests_data = document.getElementById("guests_data");
    var guest_list = document.getElementById("guest_list");
    guest_list.innerHTML = `<thead><tr><th>Name</th><th>Group</th><th>RSVP</th><th></th></tr></thead>`;
    var tbody = '';
    JSON.parse(guests_data.value).forEach(function(guest, index) {
        tbody += `<tr class="align-middle">
                                <td>${guest.first_name} ${guest.last_name}</td>
                                <td class="row-group small">${guest.group}</td>
                                <td class="row-status">
                                    <select class="form-select form-select-sm" onchange="updateRsvp(this, ${index}, false)">
                                        <option value="" ${isSelected(guest.status, null)}>No Response</option>
                                        <option value="1" ${isSelected(guest.status, true)}>Coming</option>
                                        <option value="0" ${isSelected(guest.status, false)}>Not Coming</option>
                                    </select>
                                </td>
                                <td class="text-end"><button type="button" class="btn btn-secondary btn-sm remove" onclick="removeRow(${index})"><i class="bi bi-trash3"></i></button></td>
                            </tr>`;
        guest.guests_attributes.forEach(function(element, idx){
            tbody += `<tr class="align-middle text-muted">
                                <td>&#x21B3; ${element.first_name} ${element.last_name}</td>
                                <td class="row-group small">-</td>
                                <td class="row-status">
                                    <select class="form-select form-select-sm" onchange="updateRsvp(this, ${index}, ${idx})">
                                        <option value="" ${isSelected(element.status, null)}>No Response</option>
                                        <option value="1" ${isSelected(element.status, true)}>Coming</option>
                                        <option value="0" ${isSelected(element.status, false)}>Not Coming</option>
                                    </select>
                                </td>
                                <td class="text-end"><button type="button" class="btn btn-secondary btn-sm remove" onclick="removePlusOne(${index}, ${idx})"><i class="bi bi-trash3"></i></button></td>
                            </tr>`;
        });
    });
    guest_list.innerHTML += `<tbody>${tbody}</tbody>`;
}();

var addRow = function() {
    var first_names = document.getElementsByName("first_name");
    var last_names = document.getElementsByName("last_name");
    var group = document.getElementById("group");
    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    var guests_attributes = [];
    for(i = 1; i < first_names.length; i++) {
        console.log(first_names[i].value);
        guests_attributes.push({
            first_name: first_names[i].value,
            last_name: last_names[i].value,
            group: group.value
        });
    }
    guests_json.push({
        first_name: first_names[0].value,
        last_name: last_names[0].value,
        group: group.value,
        guests_attributes: guests_attributes
    });
    guests_data.value = JSON.stringify(guests_json);
    document.getElementById("guests").submit();
};

var removeRow = function(index) {
    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    guests_json.splice(index, 1);
    guests_data.value = JSON.stringify(guests_json);
    document.getElementById("guests").submit();
};

var removePlusOne = function(parent, child) {
    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    guests_json[parent].guests_attributes.splice(child,1);
    guests_data.value = JSON.stringify(guests_json);
    document.getElementById("guests").submit();
};

var updateRsvp = function(element, parent, child) {
    var guests_data = document.getElementById("guests_data");
    var guests_json = JSON.parse(guests_data.value);
    var status = element.value === "" ? null : element.value === "1";
    if(child === false){
        guests_json[parent].status = status;
    } else {
        guests_json[parent].guests_attributes[child].status = status;
    }
    guests_data.value = JSON.stringify(guests_json);
    document.getElementById("guests").submit();
};

var filterByGroup = function() {
    var filter = document.getElementById("group_filter");
    var elements = document.getElementsByClassName("row-group");
    for (element of elements) {
        if (filter.value === "") {
            element.parentElement.classList.remove('d-none');
        } else if(element.innerHTML === filter.value){
            element.parentElement.classList.remove('d-none');
        } else {
            element.parentElement.classList.add('d-none');
        }
    }
};

var filterByStatus = function() {
    var filter = document.getElementById("status_filter");
    var elements = document.getElementsByClassName("row-status");
    console.log(filter.value);
    for (element of elements) {
        console.log(element.children[0].value);
        if (filter.value === "") {
            element.parentElement.classList.remove('d-none');
        } else if(element.children[0].options[element.children[0].selectedIndex].text === filter.value){
            element.parentElement.classList.remove('d-none');
        } else {
            element.parentElement.classList.add('d-none');
        }
    }
};

var additionalGuest = function(parent_id) {
    var container = document.getElementById("additional-guests");
    container.innerHTML += `<div class="row mb-2">
                                <div class="col">
                                    <input class="form-control" placeholder="First name" type="text" name="first_name">
                                </div>
                                <div class="col">
                                    <input class="form-control" placeholder="Last name" type="text" name="last_name">
                                </div>
                            </div>`;
};
