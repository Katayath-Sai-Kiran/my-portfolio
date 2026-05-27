# Sai Kiran — Flutter Web Portfolio

A clean, modern, responsive portfolio website built with **Flutter Web**.

## ✨ Features

- 🎨 Dark theme with gradient accents
- 📱 Fully responsive (Mobile, Tablet, Desktop)
- ⚡ Smooth animations with `flutter_animate`
- 🗂️ Sections: Hero · About · Skills · Projects · Experience · Contact
- 🏗️ Clean feature-based architecture with Provider state management

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.8.0
- Chrome browser

### Run locally

```bash
flutter pub get
flutter run -d chrome --web-renderer canvaskit
```

### Build for production

```bash
flutter build web --web-renderer canvaskit --release
```

## 🗂️ Project Structure

```
lib/
  core/
    constants/     # Colors, strings, text styles, dimensions
    theme/         # App theme
    utils/         # Responsive helper, scroll utils
  features/
    hero/          # Hero / landing section
    about/         # About section
    skills/        # Skills section
    projects/      # Projects section
    experience/    # Experience timeline
    contact/       # Contact form
  shared/
    data/          # Static portfolio data (edit here!)
    models/        # Data models
    providers/     # ScrollProvider
    widgets/       # NavBar, Footer, SectionTitle, GradientButton
  main.dart
```

## 🛠️ Personalizing

1. **Content** — Edit `lib/shared/data/portfolio_data.dart` to update projects, skills, and experience.
2. **Personal info** — Edit `lib/core/constants/app_strings.dart` for name, bio, and social links.
3. **Colors** — Edit `lib/core/constants/app_colors.dart` to change the color palette.
4. **Photo** — Place your photo in `assets/images/` and update `HeroSection`.

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `provider` | State management |
| `flutter_animate` | Animations |
| `google_fonts` | Typography (Inter, Fira Code) |
| `url_launcher` | Open external links |
| `font_awesome_flutter` | Icons |
