import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';
import 'article_grid_item.dart';

class NewsGridView extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onArticleTap;

  const NewsGridView({
    super.key,
    required this.articles,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleGridItem(
          article: article,
          onTap: () => onArticleTap(article),
        );
      },
    );
  }
}
