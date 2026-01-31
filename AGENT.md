# GEMINI.md

This file provides a comprehensive overview of the ennaa_ffeeelinggu project, its purpose, and how to contribute.

## Project Overview

ennaa_ffeeelinggu is a mobile application for iOS and Android that allows users to track their mood and activities on an hourly basis. The primary goal is to provide users with a simple and intuitive way to log their emotional state and what they are doing throughout the day.

The application is built with Flutter and stores all data locally on the user's device using SQLite.

## Features

The core features of the application include:

*   **Mood Tracking:** Users can rate their mood on a scale of 1 to 10, represented by emojis.
*   **Activity Tracking:** Users can enter a short text description of their current activity.
*   **Hourly Logging:** The app is designed for hourly logging, with optional reminders.
*   **History/Timeline View:** A chronological view of all past entries.

For more detailed information, please refer to the specification document at `specs/001-mood_and_activity_tracking/specification.md`.

## Getting Started

To get started with the project, you will need to have Flutter installed. You can find instructions on how to install Flutter in the [official documentation](https://docs.flutter.dev/get-started/install).

Once you have Flutter installed, you can clone the repository and run the application:

```bash
git clone https://github.com/your-username/ennaa_ffeeelinggu.git
cd ennaa_ffeeelinggu
flutter pub get
flutter run
```

## Building and Running

### Running the application

To run the application, use the following command:

```bash
flutter run
```

This will run the application on a connected device or emulator.

### Building the application

To build the application for a specific platform, use the following commands:

**Android:**

```bash
flutter build apk
```

**iOS:**

```bash
flutter build ios
```

## Development Conventions

### Code Style

This project uses the default Dart and Flutter analysis options. You can find the configuration in the `analysis_options.yaml` file. Please run the Dart analyzer to check for any issues before submitting a pull request:

```bash
dart analyze
```

### Testing

The project does not currently have any tests. However, all new features should be accompanied by tests.
