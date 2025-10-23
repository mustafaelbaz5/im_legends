# im_legends

# IM Legends — README.md

> Professional, friendly README for the **IM Legends** Flutter app — generated after a deep read of the provided project sources.

---

## Project Overview

**IM Legends** is a cross-platform Flutter application for tracking competitive matches and player leaderboards.

It includes user authentication, profile & image storage, match history, push & local notifications, and a polished UI with onboarding and a bottom navigation shell. The app uses Supabase for backend database & storage and Firebase for push notifications and related services. project_code

 project_code

---

## Tech Stack

* **Framework:** Flutter (Dart)
* **State management:** flutter_bloc (Cubits)
* **Dependency injection:** GetIt. project_code
* **Routing:** GoRouter. project_code
* **Backend / DB / Storage:** Supabase (PostgREST + Storage). project_code
* **Push / Messaging:** Firebase Messaging + local notifications. project_code
* **Local storage:** SharedPreferences, flutter_secure_storage. project_code
* **Other notable libs:** cached_network_image, image_picker, flutter_screenutil, sqflite (platform plugins), url_launcher, flutter_local_notifications (and related platform plugins). project_code

---

## Architecture (high level)

IM Legends follows a layered, feature-based architecture:

* **`lib/core`**
  * Shared utilities, theming, routing, DI, services (Supabase wrapper), widgets and app entry. project_code
* **`lib/features/<feature>`**
  * Each feature (auth, home, profile, add_match, champion, history, notification, onboarding, etc.) contains:
    * `data` (services/repos/models),
    * `logic` (Bloc/Cubit),
    * `ui` (screens & widgets).
* **DI & Initialization**
  * `setupGetIt()` registers services, repositories and Cubits; app initializers create Firebase & Supabase instances, register notification handlers, and initialize shared prefs. project_code

    project_code
* **Routing**
  * `GoRouter` with a ShellRoute for the main scaffold (bottom navigation) and guarded public routes (onboarding, login, signup). Authentication redirects are centralized in router helpers. project_code

This results in a modular codebase where features are self-contained and the `core` folder hosts cross-cutting concerns.

---

## Features

* Onboarding flow and authentication (Sign up / Login). project_code
* Home / Leaderboard showing player ranks, points and avatars. project_code
* Add match flow and match history. project_code
* Profile management with profile image upload to Supabase Storage. project_code
* Notifications: Firebase push + local notifications + in-app notification center. project_code
* Responsive UI using `flutter_screenutil`, custom theme & typography, and polished components (custom app bar, bottom nav, animated page transitions). project_code

---

## Testing

* **Current state:** No unit/widget test files were discovered in the uploaded project snapshot. (If you have test files elsewhere, include them in the repo and I can integrate / summarize them.)
* **Recommended tests to add:**

  * Unit tests for services (`SupaBaseService` wrapper, token/save/delete flows).
  * Cubit/Bloc unit tests (leaderboard loading, auth flows, add-match validations).
  * Widget tests for key screens: `HomeScreen`, `LoginScreen`, `ProfileScreen`.
* **Run tests:**

  <pre class="overflow-visible!" data-start="3799" data-end="3827" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-bash" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">flutter </span><span data--h-bstatus="0OBSERVED">test</span><span data--h-bstatus="0OBSERVED">
  </span></span></code></div></div></pre>

  (Add `integration_test` if you plan E2E tests.)

---

## Folder structure (summary / example)

<pre class="overflow-visible!" data-start="3924" data-end="4523" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre!" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">lib/
├─ core/
│  ├─ di/                   </span><span data--h-bstatus="0OBSERVED"># dependency injection (GetIt)</span><span data--h-bstatus="0OBSERVED">
│  ├─ router/               </span><span data--h-bstatus="0OBSERVED"># app routing (GoRouter)</span><span data--h-bstatus="0OBSERVED">
│  ├─ service/              </span><span data--h-bstatus="0OBSERVED"># Supabase + helper services</span><span data--h-bstatus="0OBSERVED">
│  ├─ themes/               </span><span data--h-bstatus="0OBSERVED"># colors, fonts, text styles</span><span data--h-bstatus="0OBSERVED">
│  ├─ widgets/              </span><span data--h-bstatus="0OBSERVED"># shared UI widgets</span><span data--h-bstatus="0OBSERVED">
│  └─ utils/                </span><span data--h-bstatus="0OBSERVED"># helpers, secure storage, shared prefs</span><span data--h-bstatus="0OBSERVED">
├─ features/
│  ├─ auth/
│  │  ├─ data/
│  │  ├─ logic/
│  │  └─ ui/
│  ├─ home/
│  ├─ profile/
│  ├─ add_match/
│  ├─ champion/
│  ├─ </span><span data--h-bstatus="0OBSERVED">history</span><span data--h-bstatus="0OBSERVED">/
│  └─ notification/
├─ main_development.dart
├─ main_production.dart
└─ im_legends_app.dart
</span></span></code></div></div></pre>

This layout is inferred from the source files and encourages separation between features and core utilities. project_code

 project_code

---

## How to run the project (dev & production)

> **Prerequisites** : Flutter SDK, Android/iOS toolchains, configured Firebase project for the app (google-services / plist) if you plan to test messaging, and a Supabase project configured with the same schema & anon key.

1. **Install dependencies**

   <pre class="overflow-visible!" data-start="5018" data-end="5051" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-bash" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">flutter pub get
   </span></span></code></div></div></pre>
2. **Prepare native config**

   * Add `google-services.json` / `GoogleService-Info.plist` or ensure `firebase_options.dart` is properly configured (project includes `firebase_options.dart`). project_code
   * Update Supabase URL & anon key in `main_development.dart` / `main_production.dart` if you want to use a different Supabase project. project_code
3. **Initialize (already handled in code)**

   The app initializers do:

   * Firebase initialize,
   * Local notifications init,
   * Supabase initialize,
   * Register background message handler,
   * `setupGetIt()` DI registration. project_code
4. **Run in development flavor**

   <pre class="overflow-visible!" data-start="5775" data-end="5860" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-bash" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">flutter run --flavor development --target lib/main_development.dart
   </span></span></code></div></div></pre>

   (This exact command is included as a comment in the project entry file.) project_code
5. **Run production flavor**

   <pre class="overflow-visible!" data-start="6010" data-end="6093" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-bash" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">flutter run --flavor production --target lib/main_production.dart
   </span></span></code></div></div></pre>

   (Also present as a commented command in the source.) project_code
6. **Build APK / AppBundle**

   <pre class="overflow-visible!" data-start="6223" data-end="6401" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-bash" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">flutter build apk --flavor production --target lib/main_production.dart
   </span><span data--h-bstatus="0OBSERVED"># or</span><span data--h-bstatus="0OBSERVED">
   flutter build appbundle --flavor production --target lib/main_production.dart
   </span></span></code></div></div></pre>

---

## Future Improvements (suggestions)

* Add automated tests (unit, widget, integration).
* CI/CD: GitHub Actions to run `flutter analyze`, `flutter test`, and build artifacts per flavor.
* Improve error handling & network retry policies for Supabase calls.
* Add feature flagging / remote config for enabling/disabling features without redeploy.
* Add offline-first caching for leaderboards & match history (e.g. sqflite/local DB + sync).
* Expand notification types and add deep links to notification payloads (GoRouter integration). project_code

---

## Screenshots

> Place screenshot images in `/assets/screenshots/` and add markdown here. Example:

<pre class="overflow-visible!" data-start="7098" data-end="7202" data--h-bstatus="0OBSERVED"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary" data--h-bstatus="0OBSERVED"><div class="sticky top-9" data--h-bstatus="0OBSERVED"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2" data--h-bstatus="0OBSERVED"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs" data--h-bstatus="0OBSERVED"></div></div></div><div class="overflow-y-auto p-4" dir="ltr" data--h-bstatus="0OBSERVED"><code class="whitespace-pre! language-md" data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED"><span data--h-bstatus="0OBSERVED">![</span><span data--h-bstatus="0OBSERVED">Home screen</span><span data--h-bstatus="0OBSERVED">](</span><span data--h-bstatus="0OBSERVED">assets/screenshots/home.png</span><span data--h-bstatus="0OBSERVED">)
![</span><span data--h-bstatus="0OBSERVED">Leaderboard</span><span data--h-bstatus="0OBSERVED">](</span><span data--h-bstatus="0OBSERVED">assets/screenshots/leaderboard.png</span><span data--h-bstatus="0OBSERVED">)
</span></span></code></div></div></pre>

**Tip:** commit optimized PNG/JPEG images and reference them here so the GitHub repo README displays them.

---

## Social / Contact

* **Author:** (Add your name here — e.g. `Mustafa Elbaz`)
* **Project / Repo:** (Add repo URL)
* **Twitter / LinkedIn:** (Add links)

---

## Notes & important references (from the code)

* Dependency injection and service registration live in `lib/core/di/dependency_injection.dart`. project_code
* App initialization (Firebase, Supabase, notifications & DI) is performed in `main_development.dart` and `main_production.dart`. project_code
* Routing and route guards (redirects for auth) are implemented with `GoRouter` in `lib/core/router/app_router.dart` and route paths are in `route_paths.dart`. project_code
* Core Supabase wrapper and higher level services (auth, storage, tokens, notifications) are in `lib/core/service/*` with a `SupaBaseService` that centralizes common functionality. project_code
* Example UI screens (login, signup, home) and shared widgets show the app’s polished UI approach and responsive sizing with `flutter_screenutil`. project_code

  project_cod

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
