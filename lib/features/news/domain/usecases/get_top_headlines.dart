import '../../../../core/utils/result.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository _repository;

  const GetTopHeadlines(this._repository);

  Future<Result<List<Article>>> call() => _repository.getTopHeadlines();
}
