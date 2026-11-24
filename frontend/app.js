//Hämtar olika element från HTML så att JavaScript kan arbeta med dem.
const bookingButtons = document.querySelectorAll(".book-button");
const eventChoice = document.querySelector("#event-choice");
const choiceConfirmation = document.querySelector("#choice-confirmation");
const nameConfirmation = document.querySelector("#name-confirmation");
const emailConfirmation = document.querySelector("#email-confirmation");
const phoneConfirmation = document.querySelector("#phone-confirmation");
const spotsConfirmation = document.querySelector("#spots-confirmation");
const finalConfirmation = document.querySelector("#final-confirmation");
const form = document.querySelector("#booking-form");

//Hämtar element för att kunna öppna bokningsmodalen via navigeringslänken.
const navBookLink = document.querySelector("#nav-book-link");

//Hämtar element för att kunna söka efter evenemang.
const eventSearch = document.querySelector("#event-search");
const eventCards = document.querySelectorAll(".event-card");
const searchStatus = document.querySelector("#search-status");

//Deklarera och initialisera värden för HTML-element som berör kategori-filtern
const categorySelector = document.getElementById("category-filter");
const categoryButton = document.getElementById("category-filter-button");

//Filterar evenemang baserat på söktext och kategori. Om inga evenemang matchar, visas ett meddelande.
function filterEvents() {
    const searchText = eventSearch.value.toLowerCase().trim();
    const selectedCategory = categorySelector.value;
    let visibleCount = 0;

    eventCards.forEach(function(card) {
        const eventName = card.querySelector("h3").textContent.toLowerCase();
        const eventCategory = card.dataset.category;
        const matchesSearch = eventName.includes(searchText);
        let matchesCategory = false;

        //Tittar om det valda evenemanget matchar den valda kategorin. 
        if (selectedCategory === "" || eventCategory === selectedCategory) {
            matchesCategory = true;
        }
        
        //Om både söktext och kategori matchar, visas evenemanget. Annars döljs det.
        if (matchesCategory && matchesSearch) {
            card.style.display = "";
            visibleCount++;
        } else {
            card.style.display = "none";
        }
    });

    if (visibleCount === 0) {
        searchStatus.textContent = "Inga evenemang hittades. Försök med en annan sökning eller kategori.";
    } else {
        searchStatus.textContent = "";
    }
}

//Kör samma funktion både när man skriver i sökfältet och när man klickar på Filtrera
eventSearch.addEventListener("input", filterEvents);
categoryButton.addEventListener("click", filterEvents);


//Hanterar bokningsknapparna för att öppna bokningsmodalen.
bookingButtons.forEach(function(button) {
    button.addEventListener("click", function() {
        const eventTitle = button.dataset.event;
        
        if (typeof openBookingModal === 'function') {
            openBookingModal(eventTitle);
        }
    });
});

//Hanterar länken i navigationsmenyn
navBookLink.addEventListener("click", function(event) {
    event.preventDefault(); 
    
    if (typeof openBookingModal === 'function') {
        openBookingModal(); 
    }
});

//Hanterar "Läs mer"-knapparna för att öppna modalen med evenemangsdetaljer.
const readMoreButtons = document.querySelectorAll('.read-more-btn');
readMoreButtons.forEach(function(button) {
    button.addEventListener("click", function() {
        const eventTitle = button.dataset.event;
        
        if (typeof openDetailModal === 'function') {
            openDetailModal(eventTitle);
        }
    });
});

// Validerar e-postadress
function valid(email) {
    const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return pattern.test(email);
}

//Hanterar formuläret.
form.addEventListener("submit", function(event) {
    event.preventDefault();

//Hämtar och rensar användarens uppgifter.
    const name = document.querySelector("#name").value.trim();
    const email = document.querySelector("#email").value.trim();
    const phone = document.querySelector("#telefon").value.trim();
    const spots = document.querySelector("#antal-platser").value.trim();
    const selectedEvent = eventChoice.value;
    const hasSpots = hasAvailableSpots(selectedEvent, spots);

    choiceConfirmation.textContent = "";
    nameConfirmation.textContent = "";
    emailConfirmation.textContent = "";
    phoneConfirmation.textContent = "";
    spotsConfirmation.textContent = "";
    finalConfirmation.textContent = "";

//Kontrollerar att fälten är ifyllda. Dessutom kontrollerar om telefonnummer innehåller icke-numeriska värde och validerar dess längd.
    if (selectedEvent === "") {
        choiceConfirmation.textContent = "Välj en giltigt evenemang!";
        choiceConfirmation.style.color = "red";
        return;
    } else if (name === "") {
        nameConfirmation.textContent = "Skriv in ditt namn!";
        nameConfirmation.style.color = "red";
        return;
    } else if (!valid(email) || email === "") {
        emailConfirmation.textContent = "Ange en giltig e-postadress!";
        emailConfirmation.style.color = "red";
        return;
    } else if (isNaN(phone) || phone === "") {
        phoneConfirmation.textContent = "Telefon ska innehålla endast siffror!";
        phoneConfirmation.style.color = "red";
        return;
    } else if (phone.length < 8 || phone.length > 14) {
        phoneConfirmation.textContent = `Telefonnumret ska vara mellan 8 och 14 siffror långt! Ditt telefonnummer längd: ${phone.length}`;
        phoneConfirmation.style.color = "red";
        return;
    } else if (spots < 1 || spots > 5) {
        spotsConfirmation.textContent = "Du kan bara boka mellan 1 och 5 platser.";
        spotsConfirmation.style.color = "red";
        return;
    } else if (!hasSpots) {
        spotsConfirmation.textContent = "Tyvärr, det finns inga tillräckliga platser kvar för din bokning av detta evenemang.";
        spotsConfirmation.style.color = "red";
        return;
    }
        
//Visar bokningsbekräftelse
    finalConfirmation.textContent = "DU ÄR ANMÄLD TILL " + selectedEvent + "!";
    finalConfirmation.style.color = "green";
    finalConfirmation.style.fontSize = "24px";
    deductSpot(selectedEvent, spots);

    form.reset();
    console.log("Bokningsformuläret har skickats.");
});

// Rensar bokningsbekräftelsen så fort användaren börjar skriva i formuläret igen
form.addEventListener("input", function() {
    finalConfirmation.textContent = "";
});

// Hämta värden för att kunna hantera en asynkron kod som ska använda sig av API för utbyte av data, och sedan presentera i HTML format
const apiURL = "http://localhost:5043/api/events";
const apiLoadButton = document.querySelector("#api-load-button");
const apiStatus = document.querySelector("#api-status");
const apiEventsList = document.querySelector("#api-event-list");

// Värden för att kunna presentera information på tydligare sätt när fiktiva evenemang hämtas
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


// API-integrerad kod som ska hämta JSON-data och presentera det i HTML-format, vilket är för en fiktiv evenemang lista
async function loadEventList(){
    apiStatus.textContent = "Hämtar en lista av fiktiva evenemang...";
    apiEventsList.replaceChildren(); 
    apiLoadButton.disabled = true;

    let errorMessage = "Fiktiva evenemang kunde inte hämtas! Försök igen.";
    let errorMessageNetwork = "Kunde inte ansluta till API:t. Kontrollera att servern är igång och försök igen.";
    let isHttpError = false;

    // Använder try-catch för att hantera eventuella fel som kan uppstå vid hämtning av data från API:t
    try {

        const response = await fetch(apiURL);

        // Kontrollerar om HTTP-svaret misslyckades
        if(!response.ok){
            isHttpError = true;
            if(response.status === 404){
                errorMessage = "Fiktiva evenemang kunde inte hittas.";
            } else if(response.status >= 500 && response.status <= 599){
                errorMessage = "Det förekom fel i servern. Försök igen senare!";
            }

            throw new Error(`HTTP-error: ${response.status}`);
        }

        const events = await response.json();

        if(events.length === 0){
            apiStatus.textContent = "Åh nej, det fanns inga fiktiva evenemang att visa just nu!";
            return;
        }

        // Loopar igenom evenemangen och skapar HTML-element för att visa dem
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

        apiStatus.textContent = `${events.length} fiktiva evenemang finns!`;

    } catch(error) {
        console.error("Kunde inte hämta fiktiva evenemang.");

        // Skiljer på nätverksfel när API är nere och HTTP-fel när API är uppe men inte kan leverera data
        if(!isHttpError && error instanceof TypeError){
            apiStatus.textContent = errorMessageNetwork;
        } else {
            apiStatus.textContent = errorMessage;
        }
    } finally {
        apiLoadButton.disabled = false;
    }
}

apiLoadButton.addEventListener('click', loadEventList);