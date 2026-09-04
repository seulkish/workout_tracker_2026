# Project Summary: Workout Tracker 2026

## Overview
This is a Flutter-based workout tracking application developed as part of a "용산 실습 프로젝트" (Yongsan Practice Project). It uses Firebase for authentication, database (Firestore), and storage.

## Current Architecture
- **State Management**: `provider` package is used for managing workout data (`MyWorkoutProvider`).
- **Navigation**: `go_router` is used for handling app routes and deep linking.
- **Backend**:
    - **Firebase Auth**: User login, registration, and password reset.
    - **Cloud Firestore**: CRUD operations for workout records.
    - **Firebase Storage**: Storing workout-related images.
- **UI Design**: Uses `flex_color_scheme` for theming (Blue/Red Wine themes).

## Core Components
- **Models**: `MyWorkout` (defines the structure of a workout record).
- **Services**:
    - `FirebaseAuthService`: Authentication logic.
    - `FirestoreService`: Firestore CRUD operations.
    - `FirebaseStorageService`: Storage operations.
- **Pages**:
    - `LandingPage`: Initial screen.
    - `WorkoutHomePage`: Main hub for workouts.
    - `MyWorkoutListPage`: Displays user's saved workouts with pagination.
    - `WorkoutListPage`: Displays a list of available workouts by category.
    - `SettingsPage`: Profile and login management.

## Status & TODOs (from README)
- [x] Firebase authentication
- [x] WordPress API CRUD (Note: Code seems to have shifted to Firestore)
- [x] Firebase storage connection
- [ ] Implement workout guide logic (in progress)

## Recent Activity
- Focus on `MyWorkoutListPage` pagination and interaction with `MyWorkoutProvider`.
- Implementation of `AddWorkoutDialog` for creating new records.
