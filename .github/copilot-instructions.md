# Sai Kiran Portfolio - Copilot Instructions

## Project Overview
A Flutter Web portfolio website for Sai Kiran. Clean, modern, responsive single-page application with sections: Hero, About, Skills, Projects, Experience, and Contact.

## Architecture
- **State Management**: Provider pattern with ChangeNotifier
- **Structure**: Feature-based folder organization
- **Responsive**: Mobile, Tablet, Desktop breakpoints using LayoutBuilder
- **Routing**: go_router for named routes

## Folder Structure
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
  shared/
    widgets/         # Reusable widgets (nav bar, footer, section title, etc.)
    providers/       # Shared providers (scroll, theme)
  main.dart
```

## Coding Standards
- Always use `const` constructors where possible
- Use named parameters for widget constructors
- Responsive breakpoints: mobile < 600, tablet < 1024, desktop >= 1024
- Never access state directly in UI; always go through providers
