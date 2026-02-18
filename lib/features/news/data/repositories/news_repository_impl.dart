import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _dataSource;

  const NewsRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<Article>>> getTopHeadlines() async {
    try {
      final models = await _dataSource.getTopHeadlines();

      if (models.isEmpty) {
        return const Failure(NoDataException('No articles found'));
      }

      final articles = models.map((m) => m.toEntity()).toList();
      return Success(articles);
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ServerException(e.toString()));
    }
  }
}
