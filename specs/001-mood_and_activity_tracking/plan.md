# Technical Plan: Mood and Activity Tracking App

## 1. Overview

This document outlines the technical implementation plan for the Mood and Activity Tracking mobile application, based on the provided specification. The plan covers architecture, data modeling, database interaction, and a step-by-step guide for development.

## 2. Architecture

We will follow a simple, scalable feature-driven architecture for the Flutter application.

### 2.1. Directory Structure

```
lib/
├── main.dart                 # App entry point and root widget
├── src/
│   ├── models/
│   │   └── journal_entry.dart  # Data model for a single entry
│   ├── services/
│   │   ├── database_service.dart # Handles all SQLite database operations
│   │   └── notification_service.dart # Manages local notifications
│   ├── screens/
│   │   ├── home_screen.dart        # Dashboard view
│   │   ├── entry_screen.dart       # Screen for adding/editing entries
│   │   └── history_screen.dart     # Chronological list of all entries
│   └── widgets/
│       └── mood_selector.widget.dart # Reusable widget for mood selection
└── utils/
    └── emoji_helper.dart       # Helper to map mood score to emoji
```

### 2.2. State Management

For simplicity and to align with the non-functional requirement of being "extremely easy and fast to use," we will use the **Provider** package for state management. A `JournalProvider` will be created to manage the state of journal entries, notify listeners of changes, and interact with the `DatabaseService`.

## 3. Data Model

A single data model, `JournalEntry`, will represent a user's log.

### `JournalEntry` (`lib/src/models/journal_entry.dart`)

| Field       | Data Type | Description                                   |
|-------------|-----------|-----------------------------------------------|
| `id`        | `int`     | Unique identifier (auto-incrementing integer) |
| `mood`      | `int`     | Mood rating from 1 to 10.                     |
| `activity`  | `String`  | User's activity description (max 280 chars).  |
| `timestamp` | `DateTime`| The date and time the entry was created.      |

This model will include `toMap()` and `fromMap()` methods for easy conversion for database storage.

## 4. API Contracts (Local Database)

Interaction with the local database will be abstracted through a `DatabaseService` class.

### `DatabaseService` (`lib/src/services/database_service.dart`)

**SQL Table:** `journal_entries`

```sql
CREATE TABLE journal_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mood INTEGER NOT NULL,
  activity TEXT NOT NULL,
  timestamp TEXT NOT NULL
);
```

**Methods:**

-   `Future<void> initDB()`: Initializes the database and creates the table if it doesn't exist.
-   `Future<int> addEntry(JournalEntry entry)`: Adds a new entry to the database and returns its ID.
-   `Future<List<JournalEntry>> getEntries()`: Retrieves all journal entries, sorted by timestamp in descending order.

## 5. Dependencies

The following packages will be added to `pubspec.yaml`:

-   **`sqflite`**: For local database storage.
-   **`path_provider`**: To find the correct local path for the database file.
-   **`flutter_local_notifications`**: To schedule and display hourly reminder notifications.
-   **`provider`**: For simple and efficient state management.
-   **`intl`**: For formatting dates and times displayed in the UI.

## 6. Step-by-Step Implementation Plan

1.  **Project Setup:**
    -   Add the required dependencies listed above to `pubspec.yaml`.
    -   Create the directory structure as defined in section 2.1.

2.  **Data and Services:**
    -   Implement the `JournalEntry` model in `journal_entry.dart`.
    -   Implement the `DatabaseService` with all its methods. Ensure it is a singleton or provided globally.
    -   Implement the `NotificationService` to handle initialization and scheduling of hourly notifications.

3.  **Core UI - Entry Screen:**
    -   Build the `EntryScreen` UI.
    -   Create the `MoodSelector` widget with tappable emojis that update the selected mood state.
    -   Add a `TextField` for the activity description with a character limit.
    -   Implement the "Save" functionality, which will create a `JournalEntry` and use the `DatabaseService` to save it.

4.  **State Management:**
    -   Create a `JournalProvider` that holds a list of `JournalEntry` objects.
    -   The provider will use `DatabaseService` to fetch, add, and manage entries.
    -   Wrap the root widget (`MaterialApp`) with a `ChangeNotifierProvider` to make the `JournalProvider` available throughout the app.

5.  **Remaining Screens:**
    -   **History Screen:** Build a `ListView` that consumes the list of entries from `JournalProvider` and displays them chronologically.
    -   **Home Screen:** Design the dashboard to show the most recent entry and a call-to-action button that navigates to the `EntryScreen`.

6.  **Integration and Finalization:**
    -   In `main.dart`, initialize `DatabaseService` and `NotificationService`.
    -   Schedule the hourly notification when the app starts.
    -   Thoroughly test all features: adding entries, viewing history, and receiving notifications.
    -   Refine the UI/UX for a polished look and feel.
