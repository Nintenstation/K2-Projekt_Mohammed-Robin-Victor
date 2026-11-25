# Eventflow

**NOTE**: All of the information presented in this project, such as events and organizers, is fictional, and is done for the purpose of 
training our skills in coding and team work. Any resemblance to real-world examples is purely coincidental.

The purpose of this project is to provide a functional, responsive and interactive web application for visitors to easily find upcoming 
events in Malmo. It is also focused on creating a normalized and coherent relational database based on the information for this project. 

The customer value of this project is for the user to both see upcoming events in Malmo, and to be able to register/book a place in the 
event of their choice. The web application of this project is meant to be responsive and have a clear semantic structure, all to ease the 
usage and accessibility for a user. The user will also be able to search events with their own keywords, or even filter events based on 
category.

The core user flow is kept simple and direct, and it is based around finding desired event(s). It goes like this: The user sees an event 
they are interested in → They click the booking button to register → Fill personal information and click register to be registered. 
However the user can find the desired event(s) in more ways than just scrolling through events. For example the user may search for events 
with their own keywords in a search field, or they may filter events based on categories through a filter button and selector.

The technologies that exist in this project are a .NET project, Git version control, relational database, and a web application with 
front-end. The coding languages utilized to achieve features are primarily SQL (more specifically Transact-SQL), HTML, CSS, and JavaScript. 
Transact-SQL was implemented and used in Microsoft SQL server management studio, and HTML, CSS, and JavaScript files were created and 
modified through Visual Studio Code.

The project has an organized structure of folders, and each directory contains files specific to a particular purpose and system. The 
“database” folder contains queries in Transact-SQL to implement the database schema, data, view, procedure, and trigger for the project. 
The “docs” folder contains documentation for many different aspects of the project and its work. The “frontend” map contains the HTML, CSS, 
and JavaScript files to create a responsive and interactive web page for the project and its details. The “eventflow-api” map simply 
contains the API and necessary steps to activate and use the local API found within the project. The “K2-Projekt” is a folder for a C# file 
and its projects file, which went mostly unmodified throughout development.


## How to install and run Eventflow

### Requirements

- Visual Studio Code
- Live server extension (installed inside Visual Studio Code, in the extensions tab)
- Local git installed
- Terminal that supports git commands
- A directory to clone the Github repository

### Installation process & guide
1. Open the terminal and go to a folder of your choice.
2. Clone the Github repository for this project by typing “ git clone https://github.com/Nintenstation/K2-Projekt_Mohammed-Robin-Victor.git” and click enter.
4. Inside the cloned repository will be a folder called “frontend” which you need to open with Visual Studio Code. You can do so with commands on terminal (cd commands until you reach the “frontend” map, then “code .” to start it). Alternatively, a simpler way to do this is to choose  “open folder” on Visual Studio Code (which exists under  “File” on top-left corner) and open the “frontend” folder.
5. Once you are inside, simply right-click on the index.html file and choose “Open with Live Server. 

If you followed the steps correctly, you should now have the web application for this project, as well as the responsive and interactive 
features for it. Make sure to have Live Server installed.


## How to run SQL query files

The SQL files associated with this project exist in the “database” folder, and are written specifically in Transact-SQL. In order to use 
and run the queries, it is therefore recommended to use a program called “SQL server management studio”, which was the database manager used 
to create the relational database and all of its SQL files and queries. **IMPORTANT**: SQL-file “01-schema.sql” must be run first, and 
then “02-data.sql” file. This is to create both the database itself but also to insert all the necessary values/data. This is necessary for 
all of the other queries to work.

### Requirements

- SQL Server Management Studio
- Local git installed 
- Terminal that supports git commands

### Opening SQL files and running quries
1. If you haven’t, install Microsoft SQL Server Management Studio. Once installed, choose your local remote server, which makes it possible to create and manage a relational database.
2. If you haven’t, clone the Github repository for this project by opening a terminal compatible with installed git commands, and type and enter the following: “git clone https://github.com/Nintenstation/K2-Projekt_Mohammed-Robin-Victor.git”.
3. Open SQL Server Management Studio. Select “File” in the top-left corner, and then “Open” and then “File”. Go to the “database” folder, and select the “01-schema.sql” file. Once selected, click “Execute” on the user interface of SQL Server Management Studio. This will create the database and its tables and columns.
4. Repeat the process above, but choose “02-data.sql” this time. Execute again. This will insert all the data in their respective tables.

Now that there is a complete relational database installed and managed, choose any other SQL-file in the folder to run queries. There are 
files for creating a view, procedure, and trigger, to give more features for the database. Otherwise you can run your own queries as well.


## How to run Local API

The external API used in this project (located inside “eventflow-api” map) is within the intention of testing how to implement 
asynchronous programming into JavaScript, as well as how to use API in code to exchange data and let software components communicate and 
trade data (in the form of JSON, for this project). This API was used for a button on the web page that fetches a list of fictional events, 
with states of loading, success, empty, and error, utilizing HTTP-responses. **Keep note** that this is an external API which needs to be 
run locally, so it comes with limitations. Instructions below for how to implement this and get it running API.

### Requirements

- Git
- .NET 10 SDK

### Clone and start the API

1. Open a terminal.
2. Clone the API repository: `git clone https://github.com/m-lindberg/eventflow-api.git`
3. Navigate to the project folder where you cloned the repository, and specifically to the terminal.
4. Start the API by writing the following on the terminal, and click enter: `dotnet run --urls http://localhost:5043`

Keep the terminal open while working with the frontend.

### Verify that the API is working

Open the following URL in your browser:

http://localhost:5043/api/events

If the API is working, the events will be displayed in JSON format.

### Available endpoints

| **Endpoint** | **Description** |
|---|---|
| `/api/events` | Retrieves all events. |
| `/api/events/1` | Retrieves a specific event. |
| `/api/events/9999` | Tests a 404 error. |
| `/api/test/empty` | Tests an empty response. |
| `/api/test/error` | Tests a simulated 500 error. |

### Safety and integrity

This local API is safe and does not include any sensitive data. The programmed mechanisms make sure that the API will deliver the requested
information safely and with minimal error or corruption. For example the button for activating the API (the one that brings a list of
fictional events) is disabled during the process, and will reactivate only after the process is finished, regardless of success or failure
of fetching presentable data. The HTTP-requests and HTTP-responses do not rely on sensitive or personal information.


## Teamwork method

The team responsible for this project were operating on "Github flow", where every individual focused on working within their seperate branch
for a specific task, and were not able to do changes on the main branch directly without approval. All stages and commits of development
must be performed through a Pull Request, and requires the approval of the rest of the team. That way, the main branch contains verified
and documented stages of development that are safe and present a certified and working form of software. Everyone in the team is up-to-date
with each other. Furthermore the team implements an agile method of work, particularly Scrum, that allowed the team to constantly re-evaluate 
both the work itself and the teamwork retrospective that would deliver and improve the product. The team focused on individual features
that are related to each other in the form of quick sprints of development, and utilized the creation and reading of user stories to clarify
needed features. A Github Projects board template is associated with this project, and shows many of the ideas and features that were 
created, modified, and integrated along the way.
