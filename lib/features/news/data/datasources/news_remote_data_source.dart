import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/article_model.dart';
import '../models/news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio _dio;

  const NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'country': 'us',
          'pageSize': AppConstants.pageSize,
        },
      );

      final responseModel = NewsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (responseModel.status != 'ok') {
        throw ServerException(
            'API returned status: ${responseModel.status}');
      }

      return responseModel.articles;
    } on DioException catch (e) {
      throw NetworkException(e.message ?? 'Network error occurred');
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
