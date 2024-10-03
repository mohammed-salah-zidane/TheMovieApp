# TheMovieApp

A modular iOS application built using **SwiftUI** and **Combine**, following **Clean Architecture** and **SOLID** principles. The app fetches trending movies from TheMovieDB API, supports filtering by genres, and displays detailed information about each movie.

## Features

- **Trending Movies List**: Displays a paginated list of trending movies.
- **Search and Filter**: Supports searching movies by title and filtering by genres.
- **Movie Details**: Provides detailed information about selected movies including budget, revenue, and runtime.
---

## Architecture

The project uses **Clean Architecture** to separate concerns into distinct layers:

### 1. **Domain Layer**
   - Defines business logic and entities such as `Movie`, `Genre`, and `MovieDetail`.
   - Contains protocols for repositories and use cases, ensuring the decoupling of the business logic from implementation details.

### 2. **Data Layer**
   - Implements the repository protocols, providing access to remote data (API).
   - Contains the `RemoteDataSource`, `NetworkClient`, and the implementation of data repositories.
   - Uses `Combine` for handling asynchronous operations and data flows.

### 3. **UseCases Layer**
   - Implements business rules and use cases such as fetching trending movies, retrieving genres, and fetching movie details.
   - Communicates with repositories to execute these use cases.

### 4. **Presentation Layer**
   - Manages the UI and state using `SwiftUI` and `Combine`.
   - Contains `ViewModels` for handling the state and presentation logic.
   - Includes shared UI components such as `SearchBar`, `MovieRowView`, and `GenreChipsView`.

### 5. **Factories Layer**
   - Uses the **Factory Design Pattern** to instantiate repositories and use cases, ensuring dependency injection and separation of concerns.
   
---

## Clean Architecture

- **Separation of Concerns**: The project divides responsibilities across layers, making each layer focused on a specific task.
- **Dependency Inversion**: High-level components (e.g., ViewModels) depend on abstractions (protocols) rather than concrete implementations.
- **Testability**: Each layer is independent and can be tested in isolation using mock implementations of protocols.
- **Maintainability**: The modular architecture makes it easy to extend the app by adding new features, like additional filtering options or new data sources.

---

## SOLID Principles

1. **Single Responsibility**: Each class or struct has one responsibility (e.g., ViewModel handles UI logic, Repository handles data fetching).
2. **Open/Closed**: Classes are open for extension but closed for modification.
3. **Liskov Substitution**: Interfaces ensure that derived classes can replace base classes without altering behavior.
4. **Interface Segregation**: ViewModels only depend on specific use case protocols they need.
5. **Dependency Inversion**: High-level modules depend on abstractions (use case protocols), not concrete implementations.

---

## How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/mohammed-salah-zidane/TheMovieApp.git
   ```

2. Open the project in Xcode and run it on the simulator or device.

3. You need to replace the placeholder API key in `APIConstants.swift` with your own API key from [TheMovieDB](https://www.themoviedb.org/).

---

## How to Test

- The app uses unit tests for the **ViewModels**, **UseCases**, and **Factories**.
- Each layer can be tested independently by mocking dependencies and verifying the outputs.

To run the tests, use:
```bash
⌘ + U (in Xcode)
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---
