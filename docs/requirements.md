# Login Feature Requirements

## Goal

Build a frontend/backend separated login demo.

- Backend: Java Spring Boot in `src/`
- Frontend: React in `frontend/`

## Initial Functional Requirements

- Users can submit a username and password from the React frontend.
- The frontend calls a backend login API.
- The backend validates the request body.
- The backend returns a clear success or failure response.
- The frontend displays login success and login failure states.

## Security Requirements

- Do not store plaintext passwords.
- Do not commit real secrets.
- Do not log passwords or tokens.
- Validate backend input before authentication logic runs.
- Return generic authentication failure messages to avoid leaking account details.

## Suggested API Contract

```http
POST /api/auth/login
Content-Type: application/json
```

Request:

```json
{
  "username": "demo",
  "password": "password"
}
```

Success response:

```json
{
  "success": true,
  "message": "Login successful"
}
```

Failure response:

```json
{
  "success": false,
  "message": "Invalid username or password"
}
```

## Implementation Notes

- Start with a simple demo user if no database exists yet.
- Keep the demo user configuration isolated so it can later be replaced by a real user store.
- Add backend tests for success, wrong password, missing username, and missing password.
- Add frontend tests when the React project is initialized.

