# Meme Editor App

A simple image editing app built using Flutter with Clean Architecture.

## Features
- Drag & drop text and stickers on images
- Undo/Redo functionality
- Save edited images to gallery
- Share edited images via native intent
- Offline-friendly (if image has been loaded)
- Local metadata storage
- Dark mode support
- Modular and testable architecture

## Architecture
This project follows Clean Architecture with a modular structure:

- `presentation/` - UI, widgets, and state management using GetX
- `domain/` - Business logic, use cases, and entities
- `data/` - Data sources (local/remote) and repository implementations
- `app/` - App-level setup like routes, bindings, and entry point
- `core/` - Global utilities, constants, themes, and shared services


## Getting Started
## ⚠️ Android NDK Compatibility Warning

This project requires **Android NDK version 27.0.12077973** due to native plugins:

- `media_store_plus`
- `path_provider_android`
- `permission_handler_android`
- `share_plus`
- `sqflite_android`

If you see a warning like this:

✅ **Solution**:

1**Set NDK version 27 di `build.gradle.kts`**
   android {
       ndkVersion = "27.0.12077973"
   }


```bash
flutter pub get
flutter run
