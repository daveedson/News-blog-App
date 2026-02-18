import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';

class FeaturedArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const FeaturedArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  String _formatDate(String publishedAt) {
    try {
      final dt = DateTime.parse(publishedAt);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return publishedAt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Hero(
              tag: 'article-img-${article.url}',
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: article.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      height: 175,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 175,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 175,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported,
                            size: 48, color: Colors.grey),
                      ),
                    )
                  : Container(
                      height: 175,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.article,
                          size: 48, color: Colors.grey),
                    ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person,
                            size: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article.source,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade400),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.send_outlined,
                          size: 16, color: Colors.grey.shade400),
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
