# Sai Kiran Portfolio — AGENTS.md

## Project structure

Single Flutter web SPA (`sai_kiran_portfolio`). Real code lives under `lib/features/home/`. Many other feature dirs (`about/`, `skills/`, etc.) are empty — ignore them.

## Actual layout (6 sections, all in `home_page.dart`)

Hero → FeaturedProject → OpenSource → Articles+Experience row → Contact → Footer

Section IDs for scroll linking: `PortfolioSection` enum in `scroll_provider.dart` (`hero`, `featuredProject`, `openSource`, `articles`, `experience`, `contact`).

## State management

`Provider` + `ChangeNotifier`. Two providers: `ScrollProvider` (scrollController + visible-section tracking) and `ThemeProvider` (dark/light toggle). Both created in `main.dart`'s `MultiProvider`.

## Color system

`PortfolioColors.of(context)` — custom class in `lib/core/design/app_colors.dart` with ~15 named colors. **Do not use** `Theme.of(context).colorScheme` directly. There is a stale duplicate at `lib/core/constants/app_colors.dart` — ignore it.

## Typography

`AppTypography` in `lib/core/design/app_typography.dart`. Via `google_fonts`:
- Display/headlines: Playfair Display
- Body/titles: Inter
- Mono/meta: JetBrains Mono

## Responsive breakpoint

Single break at **768px** (mobile vs desktop), determined by `MediaQuery.sizeOf(context).width`. Old docs saying 600/1024 are stale.

## Package data — two systems

| System | File | Used by |
|---|---|---|
| `PackageModel` + `allPackages` | `lib/data/models/package_model.dart`, `lib/data/package_data.dart` | Home page Open Source section, all widgets in `features/home/widgets/` |
| `OpenSourcePackage` + `PortfolioData.packages` | `lib/shared/models/portfolio_models.dart`, `lib/shared/data/portfolio_data.dart` | Package detail page route (`/packages/:slug`) |

They are **independent** — updating one doesn't update the other. `package_data.dart` has 15 packages (3 categories: onDeviceAI, textUI, devUtilities). `portfolio_data.dart` has 14+ packages (2 categories: ai, utility).

## Key commands

```sh
flutter pub get
flutter analyze                                    # lint (flutter_lints defaults)
flutter test                                       # 1 widget test file
flutter run -d chrome --web-renderer canvaskit     # dev
flutter build web --web-renderer canvaskit --release
firebase deploy --only hosting                     # deploys build/web to ksaikiran-portfolio
```

CI (GitHub Actions) runs `flutter build web --release` on push to main and on PR. No tests run in CI.

## Router

`go_router` in `lib/core/router/app_router.dart`. Two routes:
- `/` — `HomePage`
- `/packages/:slug` — `PackageDetailPage` (reads from `PortfolioData.packages`)

Home page itself doesn't use router navigation — it's a single scroll page.

## Open Source widgets

All under `lib/features/home/widgets/`:
- `pkg_card.dart` — `PkgCard` (featured+standard variants, hover animation)
- `pkg_grid.dart` — responsive 3/2/1 columns
- `pkg_stat_card.dart` — number+label stat display
- `category_header.dart` — category name + icon + count badge
- `ai_ecosystem_chart.dart` — hierarchy chart (CustomPaint connectors)

`AiEcosystemChart` is commented out in `home_page.dart` (line ~390). Re-enabling needs the import uncommented.

## Stale files (safe to ignore/delete)

- `lib/core/constants/` (app_colors, app_dimensions, app_strings, app_text_styles) — replaced by `lib/core/design/`
- `lib/core/theme/app_theme.dart` — replaced by `lib/core/design/app_theme.dart`
- `lib/core/utils/` — not imported by live code
- Empty feature folders: about, challenges, colophon, contact, craft, ecosystem, engineering, journey, manifesto, now, open_source, packages, preface, projects, shipments, skills, words, writing

## Firebase Hosting

Project: `ksaikiran-portfolio`. Public dir: `build/web`. SPA rewrites (`**` → `/index.html`). No Firestore used by the portfolio itself (rules/indexes are left from another project).
