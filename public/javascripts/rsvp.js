var showRsvpForm = function(element) {
    element.classList.add("d-none");
    var rsvp = document.getElementById("rsvp");
    rsvp.classList.remove("d-none");
    rsvp.classList.add("fade-in");
    rsvp.scrollIntoView({ behavior: 'smooth' });
};
