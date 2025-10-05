# Omada Movies

## Architecture Overview

This app follows a lightweight MVVM (Model–View–ViewModel) architecture using modern SwiftUI and the Observation framework.

- **Views (SwiftUI)** Compose the UI and render state.
  - `MovieSearchView`: Entry screen that hosts the search field, manages navigation, and reacts to search state.
  - `MovieListView`: Renders a list of `Movie` items.
  - `MovieView`: Renders each row and pushes to details via `NavigationLink`.
  - `MovieDetailsView`, `MoviePosterImageView`, `MovieReleaseDetailsView`, `MessageView`: Focused, reusable views for details, images, metadata, and empty/error messaging.
- **ViewModels (@Observable)**: Hold UI state and business logic.
  - `MovieSearchViewModel`: Orchestrates debounced searching, state transitions, and error handling.
  - `MovieViewModel`: Adapts a `Movie` for presentation (poster URL, formatted rating, etc.).
- **Models**: Plain Swift types describing app data.
  - `Movie`: Identifiable domain model for a movie search result.
- **Services (Protocols)**: Boundary to the outside world (network, persistence, etc.).
  - `MoviesNetworkAPIFetcher` (protocol) with a concrete `MoviesSearchClient` implementation.

This structure keeps views declarative and dumb, centralizes logic in view models, and isolates side effects behind protocols for testability.

## Key Design Decisions

- **MVVM with protocol-driven boundaries**
  - View models expose protocol-based interfaces (e.g., `MovieSearchViewModeling`) to keep views decoupled from concrete implementations and enable easy mocking in tests.
- **Observation over legacy ObservableObject**
  - Uses `@Observable` (Observation framework) for simpler, more performant change tracking in Swift 6.2.
- **Single-responsibility views**
  - Small, focused views (`MoviePosterImageView`, `MessageView`, etc.) improve reuse and readability.
- **Explicit state machine for search**
  - A clear `MovieSearchViewState` drives rendering and transitions, eliminating ad-hoc boolean flags.
- **Dependency injection**
  - Services are injected via protocols (e.g., `MoviesNetworkAPIFetcher`) to enable unit testing and future swapping of implementations (e.g., local cache, different APIs).
- **Approachable Concurrency**
  - Async/await is adopted where it provides clarity (networking, debouncing) without over-complicating the codebase.

## State Management

The search flow is modeled as an explicit state machine to ensure predictable rendering and transitions:

- `.loading`: Displays a `ProgressView`.
- `.loaded([Movie])`: Shows results in `MovieListView`.
- `.empty(String)`: Shows a friendly no-results message.
- `.error(String)`: Shows a recoverable error state.

`MovieSearchViewModel` holds:
- `searchQuery`: Two-way bound to the `searchable` field.
- `debouncedSearchQuery`: Updated after a short delay to prevent spamming the API while typing.
- `viewState`: Drives the UI and transitions based on input and results.

The view listens to `debouncedSearchQuery` via `.onChange` and triggers `await viewModel.search()` to centralize side effects and state transitions.

## Networking Layer

- **Protocol-first**: `MoviesNetworkAPIFetcher` defines `searchMovies(query:page:)` for the app’s needs.
- **Concrete client**: `MoviesSearchClient` implements the protocol and performs the actual HTTP requests.
- **Testability**: Protocol driven clients allow for easy mockability to be used for testing.

This separation keeps networking isolated and makes it straightforward to add features like paging, caching, or request cancellation.

## Concurrency Strategy

- **Async/await**: Networking uses async functions for clarity and structured concurrency.
- **Debouncing**: Keystrokes are debounced (~300ms) before search execution to reduce unnecessary API calls and improve perceived performance.
- **Task usage**: The UI triggers tasks in response to user input (`.onChange`) and delegates work to the view model.

## UI Composition & Navigation

- **SwiftUI-first**: The UI uses `NavigationStack`, `.searchable`, and standard SwiftUI patterns available.
- **Row-to-details flow**: `MovieView` uses `NavigationLink` to push `MovieDetailsView` with all necessary presentation data.
- **List rendering**: `MovieListView` renders `Movie` rows using lightweight `MovieViewModel` adapters for formatting concerns.

## Error and Empty States

- Unified messaging via `MessageView` keeps the user experience consistent for empty and error states.
- Errors are surfaced with a short, user-friendly message and a distinct icon to differentiate from empty results.

## Dependency Injection & Testability

- View models accept their dependencies at initialization:
- Swap in mocks during testing to validate behaviors without hitting the network.
- Protocol abstractions make it easy to add additional implementations (e.g., cached client, offline client) without changing view code.

## Persistence (Future Roadmap)

SwiftData can be added in the future for lightweight persistence (e.g., recent searches, favorites). The app is structured so SwiftData can be introduced behind protocol boundaries without impacting UI code.

## Future Improvements

- **Testing**: Due to time constraints, unit testing of the view models and other various critical UI/E2E were not added but with the way the app is architected, adding these would be straight forward and simple.
- **Paging & infinite scroll**: Extend the search client and view model to support paging and incremental loading.
- **Caching**: Lightweight in-memory or disk caching for images and results.
- **Offline mode**: Integrate SwiftData to persist recent results and favorites for offline access.
- **Accessibility & localization**: Audit dynamic type, VoiceOver, and localize user-facing strings.
- **Error recovery**: Add retry actions and more granular error messages.
- **Observability**: Add lightweight logging and metrics around search performance and errors.

## Why these choices work well here

- The app benefits from **clear separation of concerns**: views render state, view models manage logic, services perform side effects.
- **Protocol-driven design** provides flexibility and testability without introducing third-party dependencies.
- **Modern SwiftUI & Observation** keep the code concise and expressive, aligned with the latest iOS capabilities.

## Code Documentation & Comments

Clear, concise documentation accelerates onboarding, clarifies intent, reduces bugs, and improves code reviews. This project intentionally emphasizes documentation so the codebase remains understandable and maintainable as it evolves.

## Platform and Language Choices

**Swift 6.2**
  - Embrace Apple's Approachable Concurrency to incrementally adopt async/await and structured concurrency in a clear, testable manner.
  - Uses Default Actor Isolation for safer-by-default concurrency semantics, reducing data races and making cross-actor boundaries explicit.

**Minimum deployment target: iOS 26**
  - Targets the latest platform capabilities and APIs, simplifying code paths (fewer availability checks) and ensuring access to modern system features.

By adopting Apple’s latest technologies such as SwiftData for persistence, Approachable Concurrency and Default Actor Isolation in Swift 6.2, and modern SwiftUI patterns, this project stays current with the platform and serves as a hands-on way to learn and internalize these tools. The result is cleaner, safer code and a codebase that remains maintainable as the ecosystem evolves.

## Screen Recording Links
- [Build and Functionality Walkthrough / Coding Sessions Vidoes](https://drive.google.com/drive/folders/1j9U0CoQABeJmn4p6taWpEtjHYDO5Tdsr?usp=sharing)

