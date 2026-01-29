# Specification: Mood and Activity Tracking Journaling App

## 1. Overview

A mobile application that allows users to track their mood and activities on an hourly basis. The primary goal is to provide users with a simple and intuitive way to log their emotional state and what they are doing throughout the day.

## 2. Core Features

### 2.1. Mood Tracking

-   **Mood Scale:** Users can rate their mood on a scale of 1 to 10.
    -   1 represents the worst possible mood.
    -   5 represents a neutral mood.
    -   10 represents the best possible mood.
-   **Emoji Representation:** The mood scale will be visually represented by emojis. The application will map the 1-10 scale to a corresponding set of emojis.
    -   1: 😭
    -   2: 😞
    -   3: 😧
    -   4: 😦
    -   5: 😐
    -   6: 😏
    -   7: 🙂
    -   8: 😀
    -   9: 😁
    -   10: 😂
-   **Input:** Users will select their mood using a set of selectable emoji icons.

### 2.2. Activity Tracking

-   **Activity Description:** Users can enter a short text description of their current activity.
-   **Input:** A simple text input field will be provided, limited to 280 characters.

### 2.3. Hourly Logging

-   **Frequency:** The app is designed for hourly logging.
-   **Reminders/Prompts:** The app will proactively prompt the user to enter their mood and activity every hour. This will be a configurable notification.
-   **Timestamp:** Each entry (mood + activity) will be automatically timestamped.

## 3. User Interface (UI) and User Experience (UX)

-   **Main Screen:** A dashboard view that shows the latest entry and provides a clear call-to-action to add a new entry. It might also show a summary of the day's moods.
-   **Entry Screen:** A simple screen with the mood selector (emojis/slider) and the activity text input.
-   **History/Timeline View:** A chronological view of all past entries, allowing the user to review their logs.

## 4. Technical Requirements

-   **Platform:** Mobile application for iOS and Android, built with Flutter.
-   **Data Storage:** Local storage on the device using SQLite (via the `sqflite` package).
-   **Notifications:** Local notifications for hourly reminders.

## 5. Non-Functional Requirements

-   **Simplicity:** The app should be extremely easy and fast to use.
-   **Privacy:** All data will be stored locally on the user's device.
