import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _dataSource;

  const NewsRepositoryImpl(this._dataSource);

  @override
  Future<(List<Article>?, AppException?)> getTopHeadlines() async {
    try {
      final models = await _dataSource.getTopHeadlines();

      if (models.isEmpty) {
        return (null, const NoDataException('No articles found'));
      }

      final articles = models.map((m) => m.toEntity()).toList();
      return (articles, null);
    } on AppException catch (e) {
      return (null, e);
    } catch (e) {
      return (null, ServerException(e.toString()));
    }
  }
}
