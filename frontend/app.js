const bookingButtons = document.querySelectorAll(".book-button");
const eventChoice = document.querySelector("#event-choice");
const bookingSection = document.querySelector("#booking");
const confirmation = document.querySelector("#confirmation");
const form = document.querySelector("#booking-form");

bookingButtons.forEach(function(button) {
    button.addEventListener("click", function() {
        eventChoice.value = button.dataset.event;

        bookingSection.scrollIntoView({
            behavior: "smooth"
        });
    });
});

form.addEventListener("submit", function(event) {
    event.preventDefault();

    const name = document.querySelector("#name").value.trim();
    const email = document.querySelector("#email").value.trim();
    const phone = document.querySelector("#telefon").value.trim();
    const selectedEvent = eventChoice.value;

    if (name === "" || email === "" || phone === "" || selectedEvent === "") {
        confirmation.textContent = "Fyll i alla fält!";
        confirmation.style.color = "red";
        return;
    }

    confirmation.textContent = "DU ÄR ANMÄLD TILL " + selectedEvent + "!";
    confirmation.style.color = "green";
    confirmation.style.fontSize = "24px";

    console.log("Bokningsformuläret har skickats.");
});
