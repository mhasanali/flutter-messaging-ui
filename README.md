# Flutter Messaging App 💬

A native Flutter messaging interface with WebView integration for an internal dashboard. Built with Clean Architecture and Provider state management.

## What's Inside

- **Native Chat Interface** - Real-time messaging with chat bubbles and timestamps
- **Auto-Reply Agent** - Simulated support responses (keyword-based)
- **WebView Dashboard** - Embedded Angular app for internal tools
- **Message Persistence** - SQLite database stores chat history
- **Dark Mode** - Automatically adapts to system theme

## Quick Start

### Prerequisites

- Flutter SDK (3.38+)
- Android Studio / Xcode
- Optional: Angular app running on port 4200

### Installation

1. **Clone and navigate to the project**
   cd flutter_app
    2. **Install dependencies**
       flutter pub get
    3. **Generate JSON serialization code**
       flutter pub run build_runner build --delete-conflicting-outputs
    4. **Run the app**
       flutter run
   ## WebView Setup

The Dashboard tab loads an Angular app via WebView.

### iOS Simulator / Physical Device
No changes needed - uses `http://localhost:4200`

## How It Works

1. **Send a message** → Saved to SQLite
2. **Agent responds** → Keyword detection + random responses
3. **Switch to Dashboard** → Loads Angular app in WebView
4. **Restart app** → Messages are still there (persistence)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| State Management | Provider |
| Database | SQLite (sqflite) |
| Serialization | json_serializable |
| WebView | webview_flutter |
| Architecture | Clean Architecture |


## Tests
1. **Run tests** -> flutter test
The coverage is non-existent but concept is shown by two tests, ideally all the usecases should be tested bare minimum (nenefits of clean architecture :) )