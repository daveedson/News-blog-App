import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_blog_app/core/errors/app_exception.dart';
import 'package:news_blog_app/features/news/domain/entities/article.dart';
import 'package:news_blog_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_blog_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_blog_app/features/news/presentation/providers/news_providers.dart';
import 'package:news_blog_app/features/news/presentation/viewmodels/news_feed_viewmodel.dart';



class _FakeRepository implements NewsRepository {
  final (List<Article>?, AppException?) result;
  _FakeRepository(this.result);

  @override
  Future<(List<Article>?, AppException?)> getTopHeadlines() async => result;
}


const _article = Article(
  title: 'Test Article',
  description: 'A description',
  imageUrl: 'https://example.com/img.png',
  url: 'https://example.com',
  source: 'Test Source',
  publishedAt: '2024-06-01T08:00:00Z',
);

ProviderContainer _makeContainer(NewsRepository fakeRepo) {
  return ProviderContainer(
    overrides: [
      getTopHeadlinesProvider.overrideWithValue(GetTopHeadlines(fakeRepo)),
    ],
  );
}



void main() {
  group('NewsFeedViewModel', () {
    test('emits data when repository returns articles', () async {
      final container = _makeContainer(_FakeRepository(([_article], null)));
      addTearDown(container.dispose);

      final state = await container.read(newsFeedViewModelProvider.future);
      expect(state, [_article]);
    });

    test('emits data with multiple articles', () async {
      const articles = [_article, _article];
      final container = _makeContainer(_FakeRepository((articles, null)));
      addTearDown(container.dispose);

      final state = await container.read(newsFeedViewModelProvider.future);
      expect(state.length, 2);
    });

    test('state is loading initially before build completes', () async {
      final container = _makeContainer(_FakeRepository(([_article], null)));
      addTearDown(container.dispose);

      // First read triggers the build; it should still be loading.
      final raw = container.read(newsFeedViewModelProvider);
      expect(raw.isLoading, isTrue);

      // After the future resolves the state has a value.
      await container.read(newsFeedViewModelProvider.future);
      expect(container.read(newsFeedViewModelProvider).hasValue, isTrue);
    });

    test('refresh invalidates and reloads data', () async {
      final container = _makeContainer(_FakeRepository(([_article], null)));
      addTearDown(container.dispose);

      await container.read(newsFeedViewModelProvider.future);

      await container.read(newsFeedViewModelProvider.notifier).refresh();
      await container.read(newsFeedViewModelProvider.future);

      expect(container.read(newsFeedViewModelProvider).hasValue, isTrue);
    });
  });
}
