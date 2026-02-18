import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';

class ShortArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ShortArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Hero(
              tag: 'article-img-${article.url}',
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: article.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: article.imageUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 100,
                          color: Colors.grey.shade200,
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 100,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      )
                    : Container(
                        height: 100,
                        color: Colors.grey.shade200,
                        child:
                            const Icon(Icons.article, color: Colors.grey),
                      ),
              ),
            ),
            // Text
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          size: 12, color: Colors.grey.shade400),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.source,
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
