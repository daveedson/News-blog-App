import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';
import 'article_list_item.dart';

class NewsListView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onArticleTap;

  const NewsListView({
    super.key,
    required this.articles,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleListItem(
          article: article,
          onTap: () => onArticleTap(article),
        );
      },
    );
  }
}
