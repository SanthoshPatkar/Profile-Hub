# ProfileHub - User Profile List Application

A modern iOS application built with SwiftUI that displays a list of users with search and filtering capabilities.

## Features

- Browse user profiles with avatar, contact info, and company details
- Real-time search by name or username
- Filter users by city
- View detailed user information
- Pull to refresh
- Dark mode support

## ScreenShots
<img width="280" height="600" alt="simulator_screenshot_8AC5EDD9-E063-47C0-B809-1F17D60D859A" src="https://github.com/user-attachments/assets/ab0a6f6b-1930-49fb-8984-09080b18aba4" />
<img width="280" height="600" alt="simulator_screenshot_40B36ED8-727C-44DD-8807-ABFD7D377811" src="https://github.com/user-attachments/assets/87179328-160b-4cd0-a7e2-7cf3fa77c539" />

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
