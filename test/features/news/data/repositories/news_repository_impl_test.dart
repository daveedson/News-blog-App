import 'package:flutter_test/flutter_test.dart';
import 'package:news_blog_app/core/errors/app_exception.dart';
import 'package:news_blog_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_blog_app/features/news/data/models/article_model.dart';
import 'package:news_blog_app/features/news/data/repositories/news_repository_impl.dart';



class _FakeDataSource implements NewsRemoteDataSource {
  final List<ArticleModel> articles;
  final Exception? exception;

  _FakeDataSource({this.articles = const [], this.exception});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    if (exception != null) throw exception!;
    return articles;
  }
}



const _articleModel = ArticleModel(
  title: 'Title',
  description: 'Desc',
  urlToImage: 'https://example.com/img.png',
  url: 'https://example.com',
  sourceName: 'Source',
  publishedAt: '2024-06-01T08:00:00Z',
);



void main() {
  group('NewsRepositoryImpl', () {
    test('returns articles when data source succeeds', () async {
      final repo = NewsRepositoryImpl(
        _FakeDataSource(articles: [_articleModel, _articleModel]),
      );

      final (articles, error) = await repo.getTopHeadlines();

      expect(error, isNull);
      expect(articles, hasLength(2));
      expect(articles!.first.title, 'Title');
    });

    test('maps ArticleModel to Article entity correctly', () async {
      final repo = NewsRepositoryImpl(
        _FakeDataSource(articles: [_articleModel]),
      );

      final (articles, _) = await repo.getTopHeadlines();

      final article = articles!.first;
      expect(article.title, _articleModel.title);
      expect(article.description, _articleModel.description);
      expect(article.imageUrl, _articleModel.urlToImage);
      expect(article.url, _articleModel.url);
      expect(article.source, _articleModel.sourceName);
      expect(article.publishedAt, _articleModel.publishedAt);
    });

    test('returns NoDataException when data source returns an empty list', () async {
      final repo = NewsRepositoryImpl(_FakeDataSource(articles: []));

      final (articles, error) = await repo.getTopHeadlines();

      expect(articles, isNull);
      expect(error, isA<NoDataException>());
    });

    test('propagates NetworkException from data source', () async {
      const networkError = NetworkException('No internet');
      final repo = NewsRepositoryImpl(
        _FakeDataSource(exception: networkError),
      );

      final (articles, error) = await repo.getTopHeadlines();

      expect(articles, isNull);
      expect(error, isA<NetworkException>());
      expect(error!.message, 'No internet');
    });

    test('propagates ServerException from data source', () async {
      const serverError = ServerException('Server is down');
      final repo = NewsRepositoryImpl(
        _FakeDataSource(exception: serverError),
      );

      final (articles, error) = await repo.getTopHeadlines();

      expect(articles, isNull);
      expect(error, isA<ServerException>());
      expect(error!.message, 'Server is down');
    });

    test('wraps unknown exceptions in ServerException', () async {
      final repo = NewsRepositoryImpl(
        _FakeDataSource(exception: Exception('Something unexpected')),
      );

      final (articles, error) = await repo.getTopHeadlines();

      expect(articles, isNull);
      expect(error, isA<ServerException>());
    });
  });
}
