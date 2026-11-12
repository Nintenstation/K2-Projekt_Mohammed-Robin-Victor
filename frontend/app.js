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

//Hämta värden för att kunna hantera en asynkron kod som ska använda sig av API för utbyte av data, och sedan presentera i HTML format
const apiURL = "http://localhost:5043/api/events";
const apiLoadButton = document.querySelector("#api-load-button");
const apiStatus = document.querySelector("#api-status");
const apiEventsList = document.querySelector("#api-event-list");

//Värden för att kunna presentera information på tydligare sätt när fiktiva evenemang hämtas
const Title = document.createElement("p");
Title.textContent = "Evenemangstitel: ";

const Description = document.createElement("p");
Description.textContent = "Beskrivning: ";

const StartsAt = document.createElement("p");
StartsAt.textContent = "Datum och tid: ";

const Category = document.createElement("p");
Category.textContent = "Kategori: ";

const Organizer = document.createElement("p");
Organizer.textContent = "Arrangör: ";

const Venue = document.createElement("p");
Venue.textContent = "Plats: ";


//API-integrerad kod som ska hämta JSON-data och presentera det i HTML-format, vilket är för fiktiv evenemang lista
async function loadEventList(){
    apiStatus.textContent = "Hämtar en lista av evenemang...";
    apiEventsList.replaceChildren(); 

    let errorMessage = "Evenemang kunde inte hämtas! Försök igen.";

    try {

        const response = await fetch(apiURL);

        if(!response.ok){
            if(response.status === 404){
                errorMessage = "Evenemangen kunde inte hittas.";
            } else if(response.status >= 500 && response.status <= 599){
                errorMessage = "Det förekom fel i servern. Försök igen senare!";
            }

            throw new Error(`HTTP-error: ${response.status}`);
        }

        const events = await response.json();

        if(events.length === 0){
            apiStatus.textContent = "Åh nej, det fanns inga evenemang att visa just nu!";
            return;
        }

        for(const event of events){
            const eventEntity = document.createElement("li");
            
            eventEntity.append(Title);
            eventEntity.textContent += `${event.title}\n`;

            eventEntity.append(Description);
            eventEntity.textContent += `${event.description}\n`;

            eventEntity.append(StartsAt);
            eventEntity.textContent += `${event.startsAt}\n`;

            eventEntity.append(Category);
            eventEntity.textContent += `${event.category}\n`;

            eventEntity.append(Organizer);
            eventEntity.textContent += `${event.organizer}\n`;

            eventEntity.append(Venue);
            eventEntity.textContent += `${event.venue}\n`;

            eventEntity.append(document.createElement("br"));
            
            apiEventsList.append(eventEntity);
        }

        apiStatus.textContent = `${events.length} evenemang finns!`;

    } catch(error) {
        console.error("Kunde inte hämta evenemang.");
        apiStatus.textContent = errorMessage;
    }
}

apiLoadButton.addEventListener('click', loadEventList);