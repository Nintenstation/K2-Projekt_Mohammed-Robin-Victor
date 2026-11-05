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

//Kontrollerar att fälten är ifyllda. Dessutom kontrollerar om telefonnummer innehåller icke-numeriska värde och validerar dess längd.
    if (name === "" || email === "" || phone === "" || selectedEvent === "") {
        confirmation.textContent = "Fyll i alla fält!";
        confirmation.style.color = "red";
        return;
    } else if (isNaN(phone)) {
        confirmation.textContent = "Telefon ska innehålla endast siffror!";
        confirmation.style.color = "red";
        return;
    } else if (phone.length < 8 || phone.length > 14) {
        confirmation.textContent = `Telefonnumret ska vara mellan 8 och 14 siffror långt! Ditt telefonnummer längd: ${phone.length}`;
        confirmation.style.color = "red";
        return;
    } 
        

//Visar bokningsbekräftelse
    confirmation.textContent = "DU ÄR ANMÄLD TILL " + selectedEvent + "!";
    confirmation.style.color = "green";
    confirmation.style.fontSize = "24px";

    console.log("Bokningsformuläret har skickats.");
});
