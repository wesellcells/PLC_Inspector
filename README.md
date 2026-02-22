# PLC Inspection App

## Overview
A stable mobile application for Android (and iOS-compatible) to collect measurement points during inspections. Built with Flutter, this app enables users to capture photos, record descriptions, and export inspection data.

## Features
- Camera integration for photo capture
- Automatic photo storage with predictable filenames
- Local SQLite database for offline-first operation
- Auto-incrementing measurement numbers
- CSV and JSON export functionality
- Email client integration
- Data persistence across app restarts
- Permission handling with user-friendly errors

## Installation
1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Clone repository: git clone https://github.com/wesellcells/PLC_Inspector.git
3. Navigate to project: cd PLC_Inspector
4. Get dependencies: flutter pub get
5. Run app: flutter run

## Project Structure
lib/
├── main.dart
├── models/
│   └── measurement.dart
├── services/
│   ├── database_service.dart
│   ├── camera_service.dart
│   ├── export_service.dart
│   └── email_service.dart
└── screens/
    └── inspection_screen.dart

## Testing Instructions
See inline documentation for comprehensive testing checklist.

## License
MIT