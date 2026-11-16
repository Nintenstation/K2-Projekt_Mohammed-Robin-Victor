//Hämtar olika element från HTML så att JavaScript kan arbeta med dem.
const bookingButtons = document.querySelectorAll(".book-button");
const eventChoice = document.querySelector("#event-choice");
const bookingSection = document.querySelector("#booking");
const confirmation = document.querySelector("#confirmation");
const form = document.querySelector("#booking-form");
//Hämtar element för att kunna söka efter evenemang.
const eventSearch = document.querySelector("#event-search");
const eventCards = document.querySelectorAll(".event-card");
const searchStatus = document.querySelector("#search-status");

// Hanterar sökningen efter evenemang.
eventSearch.addEventListener("input", function() {
    const searchText = eventSearch.value.toLowerCase().trim();

    eventCards.forEach(function(card) {
        const eventName = card.querySelector("h3").textContent.toLowerCase();

        if (eventName.includes(searchText)) {
            card.style.display = "";
        } else {
            card.style.display = "none";
        }
    });

    const visibleEvents = Array.from(eventCards).filter(function(card) {
        return card.style.display !== "none";
    });

    if (visibleEvents.length === 0) {
        searchStatus.textContent = "Inga evenemang hittades. Försök med en annan sökning.";
    } else {
        searchStatus.textContent = "";
    }
});

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
    apiLoadButton.disabled = true;

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
    } finally {
        apiLoadButton.disabled = false;
    }
}

apiLoadButton.addEventListener('click', loadEventList);

//Deklarera och initialisera värden för HTML-element som berör kategori-filtern
const categorySelector = document.getElementById("category-filter");
const categoryButton = document.getElementById("category-filter-button");
const categoryStatus = document.getElementById("category-filter-status");
const categoryList = document.getElementById("category-filter-list");


//Event listener för filtreringsknappen för kategori, inkluderar hämtandet av värden från select elementen på början
categoryButton.addEventListener("click", e => {
    const selectedCategory = categorySelector.value;
    categoryList.replaceChildren();

    if(selectedCategory === "music"){
        categoryStatus.textContent = "Följande evenemang för Musik:";

        const liveConcert = document.createElement("li");
        const liveConcertLink = document.createElement("a");
        liveConcertLink.textContent = "Livekonsert";
        liveConcertLink.setAttribute("href", "#live-concert");

        categoryList.append(liveConcert);
        liveConcert.append(liveConcertLink);
    } else if(selectedCategory === "sport"){
        categoryStatus.textContent = "Förljande evenemang för Sport:";

        const footballTournament = document.createElement("li");
        const footballTournamentLink = document.createElement("a");
        footballTournamentLink.textContent = "Fotbollsturnering";
        footballTournamentLink.setAttribute("href", "#football-tournament");

        categoryList.append(footballTournament);
        footballTournament.append(footballTournamentLink);
    } else if(selectedCategory === "culture"){
        categoryStatus.textContent = "Följande evenemang för Kultur: ";

        const artExhibition = document.createElement("li");
        const artExhibitionLink = document.createElement("a");
        artExhibitionLink.textContent = "Konstutställning";
        artExhibitionLink.setAttribute("href", "#art-exhibition");

        const movieNight = document.createElement("li");
        const movieNightLink = document.createElement("a");
        movieNightLink.textContent = "Movie Night";
        movieNightLink.setAttribute("href", "#movie-night");
        
        categoryList.append(artExhibition);
        artExhibition.append(artExhibitionLink);
        
        categoryList.append(movieNight);
        movieNight.append(movieNightLink);
    } else if(selectedCategory === "family"){
        categoryStatus.textContent = "Följande evenemang för Familj: ";

        const familyDay = document.createElement("li");
        const familyDayLink = document.createElement("a");
        familyDayLink.textContent = "Familjedag";
        familyDayLink.setAttribute("href", "#family-day");

        categoryList.append(familyDay);
        familyDay.append(familyDayLink);
    } else if(selectedCategory === "adventure"){
        categoryStatus.textContent = "Oj då - det finns inga evenemang för Äventyr just nu!";
    } else if(selectedCategory === ""){
        categoryStatus.textContent = "Du har inte valt kategori! Bläddra och välj kategori, sedan tryck på \"filtrera\" knappen.";
    }
}); 
