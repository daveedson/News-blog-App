import '../../domain/entities/article.dart';

class ArticleModel {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String sourceName;
  final String publishedAt;

  const ArticleModel({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.sourceName,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ?? '',
      url: json['url'] as String? ?? '',
      sourceName:
          (json['source'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
    );
  }

  Article toEntity() {
    return Article(
      title: title,
      description: description,
      imageUrl: urlToImage,
      url: url,
      source: sourceName,
      publishedAt: publishedAt,
    );
  }
}
