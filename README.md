# IM Legends 🏆

A competitive leaderboard and match tracking application built with Flutter. Track player performance, view match history, and celebrate champions in style.

## 📋 Overview

IM Legends is a comprehensive sports/gaming tournament management application that allows users to record matches, track player statistics, and maintain real-time leaderboards. The app features a modern UI with smooth animations, real-time notifications, and comprehensive player profiles.

## 🚀 Tech Stack

### Core Technologies

* **Flutter** - Cross-platform mobile framework
* **Dart** - Programming language
* **BLoC/Cubit** - State management pattern
* **GetIt** - Dependency injection

### Backend & Services

* **Supabase** - Backend as a Service (Authentication, Database, Storage)
* **Firebase** - Cloud messaging and app distribution
* **Fastlane** - Automated deployment pipeline

### Key Packages

* `flutter_bloc` - State management
* `go_router` - Declarative routing
* `flutter_secure_storage` - Secure data persistence
* `shared_preferences` - Local storage
* `image_picker` - Image selection and upload
* `flutter_local_notifications` - Push notifications
* `shimmer` - Loading animations
* `cached_network_image` - Image caching

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```text
lib/
├── core/                      # Core utilities and shared resources
│   ├── di/                    # Dependency injection setup
│   ├── models/                # Shared data models
│   ├── router/                # App navigation
│   ├── service/               # Core services
│   ├── themes/                # App theming and styles
│   ├── utils/                 # Helper functions
│   └── widgets/               # Reusable UI components
│
└── features/                  # Feature-based modules
    ├── add_match/             # Match creation
    ├── auth/                  # Authentication
    ├── champion/              # Champions view
    ├── history/               # Match history
    ├── home/                  # Leaderboard
    ├── notification/          # Notifications
    ├── onboarding/            # User onboarding
    └── profile/               # User profiles
```

Each feature follows a  **three-layer architecture** :

* **Data Layer** : Models, repositories, and services
* **Logic Layer** : BLoC/Cubit for state management
* **UI Layer** : Screens and widgets

## ✨ Features

### 🎮 Core Features

* **User Authentication** : Secure sign-up and login with profile images
* **Match Recording** : Add and track match results between players
* **Real-time Leaderboard** : Dynamic ranking system with win/loss statistics
* **Match History** : Comprehensive history of all recorded matches
* **Player Profiles** : Detailed statistics and recent match performance
* **Champions Gallery** : Showcase top-performing players
* **Push Notifications** : Real-time updates for matches and achievements

### 🎨 UI/UX Features

* **Custom Fonts** : Multiple font families (Bebas Neue, Borel, Roboto Condensed, Tajawal)
* **Gradient Backgrounds** : Beautiful gradient designs throughout
* **Shimmer Loading** : Smooth loading animations
* **Animated Transitions** : Page and component animations
* **Bottom Navigation** : Intuitive navigation system
* **Custom App Bar** : Branded top navigation
* **Dark Mode Support** : Theme-aware components

### 📱 Platform Support

* ✅ Android
* ✅ iOS
* ✅ Web
* ✅ Windows
* ✅ macOS
* ✅ Linux

## 🧪 Testing

The project includes unit and widget tests:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

Test files are located in the `test/` directory.

## 📁 Folder Structure

```text
im_legends/
├── android/                   # Android-specific code
├── ios/                       # iOS-specific code
├── web/                       # Web-specific code
├── windows/                   # Windows-specific code
├── macos/                     # macOS-specific code
├── linux/                     # Linux-specific code
├── assets/                    # Static assets
│   ├── fonts/                 # Custom fonts
│   ├── images/                # Image assets
│   └── svgs/                  # SVG icons
├── lib/
│   ├── core/                  # Core functionality
│   ├── features/              # Feature modules
│   ├── firebase_options.dart  # Firebase configuration
│   ├── im_legends_app.dart    # App initialization
│   ├── main_development.dart  # Development entry point
│   └── main_production.dart   # Production entry point
├── test/                      # Test files
└── pubspec.yaml               # Dependencies
```

## 🔧 Setup & Installation

### Prerequisites

* Flutter SDK (3.0.0 or higher)
* Dart SDK
* Android Studio / Xcode (for mobile development)
* Supabase account
* Firebase account

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/m9stafa05/im_legends.git
   cd im_legends
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Configure Supabase**
   * Create a project on [Supabase](https://supabase.com/)
   * Update `lib/core/service/supa_base_service.dart` with your credentials
4. **Configure Firebase**
   * Create a project on [Firebase Console](https://console.firebase.google.com/)
   * Download configuration files:
     * `google-services.json` (Android) → `android/app/`
     * `GoogleService-Info.plist` (iOS) → `ios/Runner/`
   * Run: `flutterfire configure`
5. **Run the app**
   ```bash
   # Development mode
   flutter run --flavor development --target lib/main_development.dart

   # Production mode
   flutter run --flavor production --target lib/main_production.dart
   ```

## 🎯 Environment Flavors

The app supports two build flavors:

* **Development** : For testing with development backend
* **Production** : For production release

Each flavor has separate Firebase configurations in:

* `android/app/src/development/google-services.json`
* `android/app/src/production/google-services.json`

## 🚀 Deployment

### Android

```bash
cd android
fastlane android deploy
```

### iOS

```bash
cd ios
fastlane ios deploy
```

The project includes automated CI/CD workflows:

```yaml
.github/workflows/android_fastlane_firebase_app_distribution_workflow.yaml
```

## 🔮 Future Improvements

* [ ] **Tournament Mode** : Create and manage tournaments
* [ ] **Team Support** : Add team-based competitions
* [ ] **Statistics Dashboard** : Advanced analytics and charts
* [ ] **Social Features** : Follow players and share achievements
* [ ] **Live Matches** : Real-time match updates
* [ ] **Chat System** : In-app messaging between players
* [ ] **Achievement System** : Badges and rewards
* [ ] **Export Reports** : PDF/Excel export of statistics
* [ ] **Multi-language Support** : Internationalization (i18n)
* [ ] **Offline Mode** : Local-first with sync

## 📸 Screenshots

> *Add your app screenshots here*

|                           Home                           |                              Add Match                              |                             Profile                             |                             History                             |
| :-------------------------------------------------------: | :-----------------------------------------------------------------: | :-------------------------------------------------------------: | :-------------------------------------------------------------: |
| ![Home Screen](https://claude.ai/chat/screenshots/home.png) | ![Add Match Screen](https://claude.ai/chat/screenshots/add_match.png) | ![Profile Screen](https://claude.ai/chat/screenshots/profile.png) | ![History Screen](https://claude.ai/chat/screenshots/history.png) |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Mustafa Elbaz**

* GitHub: [@m9stafa05](https://github.com/m9stafa05)
* LinkedIn: [Mustafa Elbaz](https://linkedin.com/in/mustafa-elbaz-725a6631a)
* Portfolio: [Mustafa Portfolio](https://mustafa-portfolio-eight.vercel.app/)
* Email: [m9stafa05@gmail.com](mailto:m9stafa05@gmail.com)

## 🙏 Acknowledgments

* Flutter team for the amazing framework
* Supabase for the powerful backend
* Firebase for cloud services
* The open-source community for inspiration

---

**Made with ❤️ and Flutter**

⭐ Star this repo if you find it helpful!
