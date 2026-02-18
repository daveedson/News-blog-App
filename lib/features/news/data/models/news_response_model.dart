import 'article_model.dart';

class NewsResponseModel {
  final String status;
  final List<ArticleModel> articles;

  const NewsResponseModel({
    required this.status,
    required this.articles,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json['status'] as String? ?? '',
      articles: (json['articles'] as List<dynamic>?)
              ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
