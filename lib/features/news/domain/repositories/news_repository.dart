import '../entities/article.dart';
import '../../../../core/errors/app_exception.dart';

abstract class NewsRepository {
  Future<(List<Article>?, AppException?)> getTopHeadlines();
}
