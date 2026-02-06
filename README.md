# ProfileHub - User Profile List Application

A modern iOS application built with SwiftUI that displays a list of users with search and filtering capabilities.

## Features

- Browse user profiles with avatar, contact info, and company details
- Real-time search by name or username
- Filter users by city
- View detailed user information
- Pull to refresh
- Dark mode support

## Architecture

**MVVM Pattern** (Model-View-ViewModel)
```
├── Models/          # Data models (User, Address, Company)
├── ViewModels/      # Business logic (UserListViewModel)
├── Views/           # UI components (List, Detail, Search)
├── Services/        # API service layer
└── Common/          # Reusable components, extensions, constants
```

## Tech Stack

| Technology | Purpose |
|------------|---------|
| **SwiftUI** | UI framework |
| **Combine** | Reactive programming |
| **Async/Await** | Asynchronous operations |
| **URLSession** | Network requests |

## Getting Started
```bash
git clone https://github.com/yourusername/profilehub.git
cd profilehub
open ProfileHub.xcodeproj
```

Run the project with `Cmd + R`


## Testing
```bash
cmd + U  # Run all tests
```

Includes:
- Unit tests for ViewModels
- Model decoding tests
- API service tests

## Author

**Santhosh G Patkar**
- GitHub: [@santhoshgpatkar](https://github.com/santhoshgpatkar)

**Built with SwiftUI & MVVM Architecture**
