import '../../../../core/errors/app_exception.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository _repository;

  const GetTopHeadlines(this._repository);

  Future<(List<Article>?, AppException?)> call() => _repository.getTopHeadlines();
}
