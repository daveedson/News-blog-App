# News Blog App

A Flutter news reader app built as a coding test. It pulls live headlines from NewsAPI and presents them in a clean, modern feed with a detail view. Simple concept, but I used it as an opportunity to build something properly — proper architecture, proper state management, proper separation of concerns.

---

## What it does

- Fetches top US headlines from [NewsAPI](https://newsapi.org)
- Displays them in a scrollable feed with a toggle between **list view** and **grid view**
- Tapping an article opens a full detail screen with a smooth **hero animation** on the image
- Pull-to-refresh to get the latest headlines
- Handles loading, error, and empty states gracefully

---

## Design

<!-- Add your Figma design screenshots/clips here -->

| Figma Frame | Figma Frame |
|---|---|
| `[ screenshot ]` | `[ screenshot ]` |

---

## App Screenshots

<!-- Add your app screenshots here -->

| Feed — List View | Feed — Grid View | Article Detail |
|---|---|---|
| `[ screenshot ]` | `[ screenshot ]` | `[ screenshot ]` |

---

## My Approach

### Architecture

I went with **Feature-first Clean Architecture** — domain, data, and presentation layers all scoped inside the `features/news/` folder. The reasoning is simple: if this app ever grows into multiple features, each one is already self-contained and easy to navigate.

```
lib/
├── core/                        # shared across features
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── providers/
│   └── utils/
├── router/
└── features/
    └── news/
        ├── data/                # models, datasources, repo impl
        ├── domain/              # entities, abstract repo, use cases
        └── presentation/        # viewmodels, providers, screens, widgets
```

### State Management — Riverpod 3.x (manual, no codegen)

I chose Riverpod because it gives you real compile-time safety and proper separation between DI and state. I kept it manual (no `@riverpod` annotations) so the provider declarations are explicit and easy to follow.

- `AsyncNotifier` for the news feed — handles loading/error/data automatically via `AsyncValue`
- `Notifier` for the list/grid view mode toggle
- `ref.invalidateSelf()` for refresh — the idiomatic Riverpod 3 way, no manual state resetting

### Error Handling

The data layer uses a sealed `AppException` hierarchy (`NetworkException`, `ServerException`, `NoDataException`) so every failure has a clear type. The repository returns a plain **Dart positional record** `(List<Article>?, AppException?)` instead of a custom sealed `Result` class — cleaner and more idiomatic Dart 3.

```dart
// repository returns this
Future<(List<Article>?, AppException?)> getTopHeadlines()

// viewmodel destructures it
final (articles, error) = await useCase.call();
if (error != null) throw error;
return articles!;
```

### Navigation — go_router

Two routes: `/news` for the feed and `/news/detail` for the article. Since NewsAPI's free tier doesn't expose a single-article endpoint, there's no meaningful ID to put in the URL — so the `Article` object is passed directly via `state.extra`. Clean and simple.

### API Key Security

The API key is never hardcoded. It's injected at compile time using `--dart-define-from-file=dart_defines.json`, which means the key lives in a gitignored local file and gets baked into the binary at build time. The `.vscode/launch.json` is committed so VS Code picks it up automatically — just add your own `dart_defines.json` with the key.

```json
// dart_defines.json  (gitignored — create this locally)
{
  "NEWS_API_KEY": "your_key_here"
}
```

### UI Details

- **Hero animation** — the article image animates seamlessly from the feed card into the detail screen using a shared `Hero` tag based on the article URL
- **List/Grid toggle** — floating action button with a scale + fade `AnimatedSwitcher` so the icon swap feels intentional, not jarring
- **Detail screen** — full-bleed image at 52% screen height, content card slides up and overlaps the image with a rounded top edge, overlay buttons (back/bookmark) sit on top of the image with a white outline style

---

## Tech Stack

| | |
|---|---|
| Framework | Flutter (Dart 3) |
| State Management | Riverpod 3.x |
| Navigation | go_router |
| Networking | Dio + PrettyDioLogger |
| Image Caching | cached_network_image |
| SVG Support | flutter_svg |
| API | NewsAPI v2 |

---

## Getting Started

1. Clone the repo
2. Run `flutter pub get`
3. Create a `dart_defines.json` file in the project root:
   ```json
   {
     "NEWS_API_KEY": "your_newsapi_key_here"
   }
   ```
4. Run with:
   ```bash
   flutter run --dart-define-from-file=dart_defines.json
   ```
   Or just use VS Code — the launch config is already set up.

> Get a free API key at [newsapi.org](https://newsapi.org)
