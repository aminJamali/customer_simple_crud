# CRUD Code Test

Create a simple CRUD application with that implements the below model:

```
Customer {
	Firstname
	Lastname
	DateOfBirth
	PhoneNumber
	Email
	BankAccountNumber
}
```

## Practices and patterns

- [TDD](https://en.wikipedia.org/wiki/Test-driven_development)
- [DDD](https://en.wikipedia.org/wiki/Domain-driven_design)
- [BDD](https://en.wikipedia.org/wiki/Behavior-driven_development): [Acceptance Test](https://en.wikipedia.org/wiki/Acceptance_testing)
- Clean Architecture
- Clean Code
- Clean git commits that show work progress.

### Validations

- Use [Google LibPhoneNumber] to validate number at the backend).

- A Valid email and a valid bank account number must be checked before submitting the form.

- Customers must be unique in database: By `Firstname`, `Lastname` and `DateOfBirth`.

- Email must be unique in the database.

### Storage

- Use Hive database to store data on the app.

### Dependency Injection

- Use [Get It] as dependency injection method.

