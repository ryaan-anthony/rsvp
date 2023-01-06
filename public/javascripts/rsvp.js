
// When the RSVP button is clicked, show the RSVP form.
var showRsvpForm = function(element) {
    element.classList.add("d-none");
    var rsvp = document.getElementById("rsvp");
    rsvp.classList.remove("d-none");
    rsvp.classList.add("fade-in");
    var guest = document.getElementById("guest");
    guest.focus();
    var rsvp_header = document.getElementById("rsvp-header");
    rsvp_header.scrollIntoView({ behavior: 'smooth' });
};

// When a name is submitted in the RSVP form, display best matches.
var findGuest = function() {
    var found = document.getElementById("matching-guests");
    found.innerHTML = '';
    var none_found = document.getElementById("none-found");
    var name_required = document.getElementById("name-required");
    none_found.classList.add("d-none");
    name_required.classList.add("d-none");

    var guests = JSON.parse(document.getElementById("guests").value);
    var query = document.getElementById("guest").value.trim();
    var names = query.split(' ');
    var first_name = names[0];
    var last_name = names[1];

    if (first_name < 3) {
        name_required.classList.remove("d-none");
        return;
    }

    var full_matches = searchGuests(guests, first_name, last_name);
    if (full_matches.length > 0) {
        renderMatchingGuests(full_matches);
        return;
    }

    var fuzzy_matches = searchGuests(guests, first_name, last_name, false);
    if (fuzzy_matches.length > 0) {
        renderMatchingGuests(fuzzy_matches);
        return;
    }

    none_found.classList.remove("d-none");
};

// Return full list of names associated with a guest.
var guestNames = function(guest) {
    var message = `<p>${guest.first_name} ${guest.last_name}</p>`;
    for (var i=0; i < guest.guests_attributes_rsvp.length; i++) {
        var person = guest.guests_attributes_rsvp[i];
        message += `<p>${person.first_name} ${person.last_name}</p>`;
    }
    return message;
};

// Reset the RSVP form to it's original state.
var resetRsvpForm = function() {
    var rsvp_form = document.getElementById("rsvp-form-container");
    rsvp_form.classList.remove('d-none');
    var matching_guests = document.getElementById("matching-guests");
    matching_guests.innerHTML = '';
    document.getElementById("guest").value = '';
    var guest = document.getElementById("guest");
    guest.focus();
    var rsvp_header = document.getElementById("rsvp-header");
    rsvp_header.scrollIntoView({ behavior: 'smooth' });
};

// Render all matching guests.
var renderMatchingGuests = function(guests) {
    var rsvp_form = document.getElementById("rsvp-form-container");
    rsvp_form.classList.add('d-none');
    var matching_guests = document.getElementById("matching-guests");
    matching_guests.innerHTML = '<p><small>Select your info below or <a class="" onclick="resetRsvpForm()">try searching again</a>.</small></p>';
    for (var i=0; i < guests.length; i++) {
        matching_guests.innerHTML += '<hr class="md-2" />';
        matching_guests.innerHTML += `<div class="row">
                                <div class="col-8">
                                    ${guestNames(guests[i])}
                                </div>
                                <div class="col text-end">
                                    <button class="btn btn-small btn-danger" onclick="selectGuest(${guests[i].id})">select</button>
                                </div>
                            </div>`;
    }
};

// Return all matching guests.
var searchGuests = function(guests, first_name, last_name, exact_match = true) {
    var found = [];
    for (var i=0; i < guests.length; i++) {
        var guest = guests[i];
        var tries = [...guest.guests_attributes_rsvp];
        tries.unshift(guest);
        for (var n=0; n < tries.length; n++) {
            var search = tries[n];
            if (matchNames(first_name, last_name, search.first_name, search.last_name, exact_match)) {
                found.push(guest);
                break;
            }
        }
    }
    return found;
};

// Simple matching logic.
var matchNames = function (first_a, last_a, first_b, last_b, exact_match) {
    if (exact_match) {
        // First and last name match
        return normalize(first_a) === normalize(first_b) &&
            normalize(last_a)  === normalize(last_b);
    }

    // Search by last name OR first names partially match
    return normalize(first_a) === normalize(last_b) ||
    normalize(first_a).includes(normalize(first_b)) ||
    normalize(first_b).includes(normalize(first_a));
};

// Ensure string is lower case.
var normalize = function(str) {
    return (str || "").toLowerCase();
};

// Select guest to update rsvp status.
var selectGuest = function(guest_id) {
    var guests = JSON.parse(document.getElementById("guests").value);
    for (var i = 0; i < guests.length; i++) {
        if (guests[i].id === guest_id) {
            renderRsvpModal(guests[i]);
            break;
        }
    }
};

// Render the RSVP modal.
var renderRsvpModal = function(guest) {
    var modal_body = document.getElementById("rsvp-form-body");
    modal_body.innerHTML = '';
    var guests = [...guest.guests_attributes_rsvp];
    guests.unshift(guest);
    for (var i = 0; i < guests.length; i++) {
        var person = guests[i];
        var yes_checked = person.status === true ? 'checked' : '';
        var no_checked = person.status === false ? 'checked' : '';
        modal_body.innerHTML += `<div class="row mb-2">
                              <div class="col text-start">
                                ${person.first_name} ${person.last_name}
                              </div>
                              <div class="col">
                                <div class="form-check form-check-inline">
                                  <input class="form-check-input attending-yes" type="radio" name="rsvp[${person.id}][status]" id="rsvp-yes-${i}" value="1" ${yes_checked}>
                                  <label class="form-check-label" for="rsvp-yes-${i}">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                  <input class="form-check-input attending-no" type="radio" name="rsvp[${person.id}][status]" id="rsvp-no-${i}" value="0" ${no_checked}>
                                  <label class="form-check-label" for="rsvp-no-${i}">No</label>
                                </div>
                              </div>
                            </div>`;
    }
    $('#update_rsvp_modal').modal('show');
};

var saveRsvpChanges = function() {
    var rsvp_form = document.getElementById("rsvp-form");
    rsvp_form.submit();
};