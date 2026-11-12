## Local API

### Requirements

- Git
- .NET 10 SDK

### Clone and start the API

1. Open a terminal.
2. Clone the API repository: `git clone https://github.com/m-lindberg/eventflow-api.git`
3. Navigate to the project folder where you cloned the repository.
4. Start the API: `dotnet run --urls http://localhost:5043`

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
