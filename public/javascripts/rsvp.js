var showRsvpForm = function(element) {
    element.classList.add("d-none");
    var rsvp = document.getElementById("rsvp");
    rsvp.classList.remove("d-none");
    rsvp.classList.add("fade-in");
    rsvp.scrollIntoView({ behavior: 'smooth' });
};

var findGuest = function() {
    renderGuest([]);
    var none_found = document.getElementById("none-found");
    var name_required = document.getElementById("name-required");
    none_found.classList.add("d-none");
    name_required.classList.add("d-none");

    var guests = JSON.parse(document.getElementById("guests").value);
    var query = document.getElementById("guest").value.trim();
    var names = query.split(' ');
    var first_name = names[0];
    var last_name = names[1];
    var found = [];

    if (!first_name) {
        name_required.classList.remove("d-none");
        return;
    }

    for (var i=0; i < guests.length; i++) {
        var guest = guests[i];
        var tries = [...guest.guests_attributes];
        tries.push(guest);
        for (var n=0; n < tries.length; n++) {
            var search = tries[n];
            if (full_match(first_name, last_name, search.first_name, search.last_name)) {
                found.push(guest);
                break;
            }
        }
    }

    if (found.length > 0) {
        return renderGuest(found);
    }

    for (var i=0; i < guests.length; i++) {
        var guest = guests[i];
        var tries = [...guest.guests_attributes];
        tries.push(guest);
        for (var n=0; n < tries.length; n++) {
            var search = tries[n];
            if (fuzzy_match(first_name, last_name, search.first_name, search.last_name)) {
                found.push(guest);
                break;
            }
        }
    }

    if (found.length > 0) {
        return renderGuest(found);
    }


    none_found.classList.remove("d-none");
};

var guestData = function(guest) {
    var message = "<p>" + guest.first_name + " " + guest.last_name + "</p>";

    for (var i=0; i < guest.guests_attributes.length; i++) {
        var person = guest.guests_attributes[i];
        console.log(person);
        message += "<p>" + person.first_name + " " + person.last_name + "</p>";
    }
    return message;
};


var renderGuest = function(guests) {
    var found = document.getElementById("found");
    found.innerHTML = '<p>Select your info below or try searching again.</p>';
    for (var i=0; i < guests.length; i++) {
        found.innerHTML += '<hr class="md-2" />';
        found.innerHTML += '<div class="row">' +
                                '<div class="col-8">' +
                                    guestData(guests[i]) +
                                '</div>' +
                                '<div class="col text-end">' +
                                    '<button class="btn btn-small btn-danger">select</button>' +
                                '</div>' +
                            '</div>';
    }
};

var fuzzy_match = function (first_a, last_a, first_b, last_b) {
    return normalize(first_a) === normalize(last_b) ||
    normalize(first_a).includes(normalize(first_b)) ||
    normalize(first_b).includes(normalize(first_a));
};

var full_match = function(first_a, last_a, first_b, last_b) {
  return normalize(first_a) === normalize(first_b) &&
         normalize(last_a)  === normalize(last_b);
};

var normalize = function(str) {
    return (str || "").toLowerCase();
};
