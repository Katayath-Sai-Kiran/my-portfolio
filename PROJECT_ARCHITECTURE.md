# Sai Kiran Portfolio

A modern, responsive Flutter Web portfolio website for Sai Kiran.

## Overview
This project is a single-page application (SPA) built with Flutter for the web. It showcases Sai Kiran's professional profile, skills, projects, experience, and contact information in a clean, visually appealing, and mobile-friendly format.

## Features
- **Hero Section**: Eye-catching landing area with name, tagline, and call-to-action.
- **About Section**: Brief biography and background.
- **Skills Section**: Visual representation of technical and soft skills.
- **Projects Section**: Portfolio of selected works with descriptions and links.
- **Experience Section**: Timeline of professional experience.
- **Contact Section**: Contact form for direct communication.
- **Additional Sections**: Challenges, Engineering, Open Source, Writing.
- **Navigation**: Responsive navigation bar and smooth scrolling.
- **Theming**: Consistent color palette and typography.
- **Responsive Design**: Optimized for mobile, tablet, and desktop breakpoints.

## Architecture
- **State Management**: Provider pattern using `ChangeNotifier` for reactive UI updates.
- **Routing**: `go_router` for named route navigation.
- **Folder Structure**:
  ```
  lib/
    core/
      constants/       # Colors, strings, text styles, dimensions
      theme/           # App theme
      utils/           # Responsive helper, scroll utils
    features/
      hero/            # Hero / landing section
      about/           # About me section
      skills/          # Skills section
      projects/        # Projects section
      experience/      # Experience / timeline section
      contact/         # Contact form section
      ...              # Other feature sections
    shared/
      widgets/         # Reusable widgets (nav bar, footer, section title, etc.)
      providers/       # Shared providers (scroll, theme)
    main.dart
  ```
- **Responsive Utilities**: `LayoutBuilder` and custom helpers for adaptive layouts.
- **Constants**: Centralized color, dimension, and string definitions for consistency.
- **Reusable Widgets**: Navigation bar, footer, section titles, and more.

## Coding Standards
- Use `const` constructors where possible for performance.
- Prefer named parameters in widget constructors.
- Responsive breakpoints: mobile < 600, tablet < 1024, desktop >= 1024.
- Never access state directly in UI; always use providers.

## Getting Started
1. **Install Flutter** (if not already): https://docs.flutter.dev/get-started/install
2. **Clone the repository**:
   ```sh
   git clone <repo-url>
   cd sai_kiran_portfolio
   ```
3. **Install dependencies**:
   ```sh
   flutter pub get
   ```
4. **Run locally**:
   ```sh
   flutter run -d chrome --web-renderer canvaskit
   ```

## Project Models
- **Section Model**: Each feature section (Hero, About, Skills, etc.) is a self-contained widget, optionally with its own provider for state.
- **Provider Model**: Shared state (e.g., theme, scroll position) is managed in `shared/providers` using `ChangeNotifier`.
- **Data Models**: Any structured data (e.g., project details, skills) is defined in `shared/models`.

## Contributing
Contributions are welcome! Please open issues or submit pull requests for improvements.

## License
This project is licensed under the MIT License.
