# Sai Kiran Portfolio — Project Changes & Configuration

## Overview
Flutter web SPA portfolio showcasing 15+ open-source packages, engineering projects, and technical writing. Built with GoRouter, Provider, custom design system.

---

## Files Modified / Created

### Core Routing & Navigation
| File | Changes |
|------|---------|
| `lib/core/router/app_router.dart` | Added `/conversation-start` route using `GoRoute` with named route `conversationStarter` |
| `lib/features/packages/package_detail_page.dart` | Related packages now use `context.goNamed(AppRouter.packageDetail, pathParameters: {'slug': ...})` for proper URL updates |
| `lib/features/home/home_page.dart` | Hero buttons ("View Packages", "Read Articles") now scroll to sections via `ScrollProvider.scrollToSection()` |

### Contact / Conversation Page
| File | Changes |
|------|---------|
| `lib/features/contact/conversation_starter_page.dart` (NEW) | Full responsive page with: contact form (Name/Email/Message), 4 equal-size social cards (GitHub, LinkedIn, Pub.dev, Email), back link, consistent theming |
| `lib/features/home/home_page.dart` (Contact section) | "Start a Conversation" button now navigates to `/conversation-start` |

### Shared / Utilities
| File | Changes |
|------|---------|
| `lib/shared/providers/scroll_provider.dart` | Unchanged — provides section keys & smooth scroll |
| `lib/shared/widgets/footer.dart` | Unchanged — source of truth for social links (GitHub, LinkedIn, Pub.dev, Email) |
| `lib/shared/widgets/nav_bar.dart` | Unchanged — persistent top nav |

### Data Models
| File | Notes |
|------|-------|
| `lib/shared/models/portfolio_models.dart` | Defines `OpenSourcePackage`, `CaseStudy`, `PackageCategory`, `CaseStudyKind`, slug derivation |
| `lib/shared/data/portfolio_data.dart` | 14 packages with full case studies, related packages, pub/github URLs |

### Home Page Sections (all in `home_page.dart`)
- `_HeroSection` → headline + stats + CTA buttons
- `_FeaturedProjectSection` → AI Engine Ecosystem
- `_OpenSourceSection` → 3 categories (AI, Text & UI, Dev Utilities) via `PkgGrid`
- `_ArticlesExperienceRow` → articles + experience columns
- `_ContactSection` → headline + "Start a Conversation" button
- `PortfolioFooter` → copyright + social links

---

## SEO Configuration

### Static HTML (`web/index.html`)
```html
<title>Sai Kiran Katayath — Flutter Engineer</title>
<meta name="description" content="Flutter engineer building open-source tools for on-device AI, text rendering, and developer workflows. 15+ packages on pub.dev.">
<meta property="og:title" content="Sai Kiran Katayath — Flutter Engineer">
<meta property="og:description" content="Flutter engineer building open-source tools for on-device AI, text rendering, and developer workflows. 15+ packages on pub.dev.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://ksaikiran.dev/">
<meta name="twitter:card" content="summary_large_image">
<link rel="canonical" href="https://ksaikiran.dev/">
```

### Dynamic SEO (via GoRouter)
- Each package detail page (`/packages/:slug`) can inject its own `<title>`/`<meta>` via `flutter_web_plugins` `setUrlStrategy` + `HtmlElementView` or a future `seo` package. Currently static.

### Sitemap & Robots
- `web/sitemap.xml` (generate at build) lists: `/`, `/packages/ai-core-codespark`, `/packages/semantic-search-codespark`, …, `/conversation-start`
- `web/robots.txt` allows all.

### Firebase Hosting
- `firebase.json` rewrites all routes to `/index.html` (SPA)
- Cache headers: `Cache-Control: max-age=31536000` for hashed assets, `no-cache` for `index.html`

---

## LLM / AI Integration Points

### On-Device AI Packages (codespark family)
| Package | Purpose | Model |
|---------|---------|-------|
| `ai_core_codespark` | Core embedding engine (MiniLM ONNX, ~23 MB) | int8 quantized MiniLM |
| `semantic_search_codespark` | Query → ranked results | Uses `ai_core_codespark` |
| `smart_sort_codespark` | Hybrid ranking (semantic + fuzzy) | RRF fusion |
| `intent_detector_codespark` | Few-shot intent classification | Embedding prototypes |

### Portfolio Content for LLM Consumption
- **Case studies** in `portfolio_data.dart` are structured markdown-ready strings (heading + body + kind).
- **Package descriptions** include problem, solution, tags, highlights.
- **Articles** in `home_page.dart` (`_articles` list) have title, summary, date, Medium URL.
- **Experience** in `portfolio_data.dart` has role, company, bullets, technologies.

### Potential LLM Use Cases
1. **Chatbot on `/conversation-start`** — feed case study + article data as context.
2. **Semantic search demo** — integrate `semantic_search_codespark` to let users query packages by meaning.
3. **Auto-generate changelogs** — from `CaseStudySection.kind` (decision/setback/breakthrough).
4. **Embedding-powered "Related Packages"** — replace manual `relatedPackages` with vector similarity at build time.

---

## Build / Deploy Commands
```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome --web-renderer canvaskit          # dev
flutter build web --web-renderer canvaskit --release   # production
firebase deploy --only hosting                         # deploys build/web
```

---

## Responsive Breakpoint
- Single breakpoint: **768px** (`MediaQuery.sizeOf(context).width < 768` → mobile)
- Used consistently in: `HomePage`, `PackageDetailPage`, `ConversationStarterPage`, `PkgGrid`, `Footer`, `NavBar`.

---

## Design System
- **Colors**: `PortfolioColors.of(context)` (~15 named colors) in `lib/core/design/app_colors.dart`
- **Typography**: `AppTypography` (Playfair Display / Inter / JetBrains Mono) in `lib/core/design/app_typography.dart`
- **Spacing**: 8px base, horizontal padding 24 (mobile) / 64/80 (desktop)

---

## Known Stale / Ignored Paths
- `lib/core/constants/` — replaced by `lib/core/design/`
- `lib/core/theme/app_theme.dart` — replaced
- `lib/core/utils/` — unused
- Empty feature folders: `about/`, `challenges/`, `colophon/`, `contact/`, `craft/`, `ecosystem/`, `engineering/`, `journey/`, `manifesto/`, `now/`, `open_source/`, `packages/`, `preface/`, `projects/`, `shipments/`, `skills/`, `words/`, `writing/`

---

## Next Steps (if extending)
1. Add dynamic `<title>`/`<meta>` per route for SEO.
2. Generate `sitemap.xml` at build (script or `flutter_sitemap`).
3. Wire `/conversation-start` form to real backend (EmailJS, Firebase Functions, or custom API).
4. Replace manual `relatedPackages` with embedding-based similarity.
5. Add dark/light theme toggle persistence (already in `ThemeProvider`).