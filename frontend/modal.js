const eventsData = [
    {
        title: 'Livekonsert',
        description: 'En kväll med livemusik.',
        date: '2026-12-01',
        time: '18:30',
        location: 'Malmö Kulturhus',
        price: '150.00 kr',
        spots: 120,
        organizer: 'Malmö Kulturhus',
        category: 'Musik',
        image: 'images/concert.jpg'
    },
    {
        title: 'Fotbollsturnering',
        description: 'En lokal fotbollsturnering.',
        date: '2026-12-03',
        time: '10:00',
        location: 'Malmö Idrottsplats',
        price: '50.00 kr',
        spots: 1,
        organizer: 'Malmö Idrottsförening',
        category: 'Sport',
        image: 'images/football.jpg'
    },
    {
        title: 'Konstutställning',
        description: 'En utställning med lokal konst.',
        date: '2026-12-05',
        time: '13:00',
        location: 'Galleri Malmö',
        price: 'Gratis',
        spots: 200,
        organizer: 'Malmö Kulturhus',
        category: 'Kultur',
        image: 'images/art.jpg'
    },
    {
        title: 'Familjedag',
        description: 'Aktiviteter för hela familjen.',
        date: '2026-12-12',
        time: '11:00',
        location: 'Folkets Park',
        price: 'Gratis',
        spots: 500,
        organizer: 'Event Malmö',
        category: 'Familj',
        image: 'images/family.jpg'
    },
    {
        title: 'Movie Night',
        description: 'En sen natt där besökare kollar på en film.',
        date: '2026-12-28',
        time: '23:59',
        location: 'Malmö Filmfestival',
        price: '259.00 kr',
        spots: 80,
        organizer: 'Malmö Kulturhus',
        category: 'Kultur',
        image: 'images/movie.jpg'
    }
];

// Hämtar referenser till modalelementen
const detailModal = document.getElementById('detail-modal');
const modalTitle = document.getElementById('modal-title');
const modalImage = document.getElementById('modal-image');
const modalDate = document.getElementById('modal-date');
const modalTime = document.getElementById('modal-time');
const modalLocation = document.getElementById('modal-location');
const modalPrice = document.getElementById('modal-price');
const modalSpots = document.getElementById('modal-spots');
const modalOrganizer = document.getElementById('modal-organizer');
const modalCategory = document.getElementById('modal-category');
const modalDesc = document.getElementById('modal-description');
// Stänger modalen när man klickar på stäng-knappen eller bokningsknappen
const closeDetailsBtn = document.querySelector('.close-detail');
const inDetailsBokaBtn = document.getElementById('modal-book-btn');

// Hämtar referenser till bokningsmodalen och dess element
const bookingModal = document.getElementById('booking-modal');
const closeBookingBtn = document.querySelector('.close-booking');
const eventChoiceDropdown = document.getElementById('event-choice');

// Öppnar detaljmodalen med information om det valda evenemanget
function openDetailModal(eventTitle) {
    // Hitta eventinformationen baserat på titeln från eventsData
    const eventInfo = eventsData.find(function(event) {
        return event.title === eventTitle;
    });

    // Om eventInfo finns, uppdatera modalen med informationen och visa den
    if (eventInfo) {
        modalTitle.textContent = eventInfo.title;
        modalImage.src = eventInfo.image;
        modalDate.textContent = eventInfo.date;
        modalTime.textContent = eventInfo.time;
        modalLocation.textContent = eventInfo.location;
        modalOrganizer.textContent = eventInfo.organizer;
        modalCategory.textContent = eventInfo.category;
        modalPrice.textContent = eventInfo.price;
        modalSpots.textContent = eventInfo.spots;
        modalDesc.textContent = eventInfo.description;

        detailModal.style.display = 'flex';
        closeDetailsBtn.focus();
    }
}

inDetailsBokaBtn.addEventListener('click', inDetailsBokaBtnClick);
// Öppnar bokningsmodalen när man klickar på "Boka" i detaljmodalen
function inDetailsBokaBtnClick() {
    closeModal();
    openBookingModal(modalTitle.textContent);
}

closeDetailsBtn.addEventListener('click', closeModal);
// Stänger detaljmodalen
function closeModal() {
    detailModal.style.display = 'none';
}

// Öppnar bokningsmodalen och förifyller eventvalet om ett evenemang är valt
function openBookingModal(eventTitle) {
    document.getElementById("final-confirmation").textContent = "";
    
    if (eventTitle) {
        eventChoiceDropdown.value = eventTitle;
    }
    bookingModal.style.display = 'flex';
    closeBookingBtn.focus();
}

closeBookingBtn.addEventListener('click', closeBookingModal);
// Stänger bokningsmodalen
function closeBookingModal() {
    bookingModal.style.display = 'none';
}

window.addEventListener('click', function(event) {
    if (event.target === detailModal) {
        closeModal();
    }
    if (event.target === bookingModal) {
        closeBookingModal();
    }
});

// Kollar om det finns tillräckligt många platser kvar
function hasAvailableSpots(eventTitle, requestedSpots) {
    const eventInfo = eventsData.find(function(ev) {
        return ev.title === eventTitle;
    });

    if (!eventInfo) {
        return false;
    }

    const spotsWanted = Number(requestedSpots);
    if (eventInfo && eventInfo.spots >= spotsWanted) {
        console.log("Enough spots for event:", eventTitle, "Requested:", spotsWanted, "Available:", eventInfo.spots);
        return true;
        
    } else {
        console.log("Not enough spots for event:", eventTitle, "Requested:", spotsWanted, "Available:", eventInfo.spots);
        return false;
    }
}

// Drar av valt antal platser (används först när formuläret är felfritt)
function deductSpot(eventTitle, requestedSpots) {
    const eventInfo = eventsData.find(function(ev) {
        return ev.title === eventTitle;
    });
    const spotsWanted = Number(requestedSpots);
    if (eventInfo && eventInfo.spots >= spotsWanted) {
        eventInfo.spots = eventInfo.spots - spotsWanted;
        console.log("Spots deducted for event:", eventTitle, "Requested:", spotsWanted, "Remaining:", eventInfo.spots);
    }
}
