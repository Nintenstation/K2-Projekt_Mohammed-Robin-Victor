//Hämtar olika element från HTML så att JavaScript kan arbeta med dem.
const bookingButtons = document.querySelectorAll(".book-button");
const eventChoice = document.querySelector("#event-choice");
const bookingSection = document.querySelector("#booking");
const confirmation = document.querySelector("#confirmation");
const form = document.querySelector("#booking-form");

//Hanterar bokningsknapparna.
bookingButtons.forEach(function(button) {
    button.addEventListener("click", function() {
        eventChoice.value = button.dataset.event;

        bookingSection.scrollIntoView({
            behavior: "smooth"
        });
    });
});

//Hanterar formuläret.
form.addEventListener("submit", function(event) {
    event.preventDefault();

//Hämtar och rensar användarens uppgifter.
    const name = document.querySelector("#name").value.trim();
    const email = document.querySelector("#email").value.trim();
    const phone = document.querySelector("#telefon").value.trim();
    const selectedEvent = eventChoice.value;

//Kontrollerar att fälten är ifyllda.
    if (name === "" || email === "" || phone === "" || selectedEvent === "") {
        confirmation.textContent = "Fyll i alla fält!";
        confirmation.style.color = "red";
        return;
    }

//Visar bokningsbekräftelse
    confirmation.textContent = "DU ÄR ANMÄLD TILL " + selectedEvent + "!";
    confirmation.style.color = "green";
    confirmation.style.fontSize = "24px";

    console.log("Bokningsformuläret har skickats.");
});
