# ArticleProvider Implementation Plan

Implement `ArticleProvider` using the `provider` package to manage the state of workout articles fetched from the WordPress API. This will centralize the article data and loading logic, making it easier to manage across the app.

## Proposed Changes

### Logic Component

#### [NEW] [article_provider.dart](file:///C:/Users/DevHjj/StudioProjects/workout_tracker_2026/lib/logic/article_provider.dart)
- Define `ArticleProvider` class extending `ChangeNotifier`.
- Integrate `ArticleApiService`.
- Maintain a list of articles, loading status, and error messages.
- Implement a `fetchArticles()` method to update the state.

### App Configuration

#### [MODIFY] [main.dart](file:///C:/Users/DevHjj/StudioProjects/workout_tracker_2026/lib/main.dart)
- Add `ArticleProvider` to the `MultiProvider` widget.

### UI Component

#### [MODIFY] [workout_article_list_page.dart](file:///C:/Users/DevHjj/StudioProjects/workout_tracker_2026/lib/pages/workout_article_list_page.dart)
- Remove local state management logic (`_isLoading`, `_articles`, `_fetchArticles`).
- Use `Provider.of<ArticleProvider>` or `Consumer<ArticleProvider>` to access and display article data.
- Call `articleProvider.fetchArticles()` on initialization or refresh.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no syntax or type errors.

### Manual Verification
- Launch the app and navigate to the **Article** tab.
- Verify that articles are loaded from the API.
- Test the refresh functionality.
- Ensure that the loading indicator and error messages (if any) are displayed correctly.
