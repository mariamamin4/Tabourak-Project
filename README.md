# megapro


This is the backend for the booking System .
It is built with ASP.NET Core Web API and Entity Framework Core using an InMemory database .
The backend exposes REST APIs to manage tickets and basic user authentication.





#Structure


Models/Ticket.cs
Defines the ticket entity with the following fields:

Id → Ticket ID (provided by the frontend, not auto-generated).

Username → Name of the customer.

Service → Selected service.

Branch → Selected branch.

TicketNumber → Sequential ticket number.

Status, Date, Time, Wait → Additional ticket details.

Models/User.cs
Defines the user entity for authentication:

Id → User ID.

Email → User email (used for login).

Password → User password (stored in plain text for demo purposes).

Data/AppDbContext.cs

Contains DbSet<Ticket> Tickets and DbSet<User> Users.

Configured with EF Core InMemory database.

Data is temporary and will reset when the app restarts.

Controllers/TicketsController.cs
Implements full CRUD APIs for tickets:

GET /api/tickets → Returns all tickets.

GET /api/tickets/{id} → Returns a single ticket by ID.

POST /api/tickets → Creates a new ticket (using the ID from frontend).

PUT /api/tickets/{id} → Updates an existing ticket.

DELETE /api/tickets/{id} → Deletes a ticket.

Controllers/AuthController.cs
Handles basic user authentication:

POST /api/auth/signup → Register a new user.

POST /api/auth/login → Sign in with existing user credentials.
