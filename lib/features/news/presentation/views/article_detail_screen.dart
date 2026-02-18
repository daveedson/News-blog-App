import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/article.dart';
import 'widgets/overlay_button.dart';
import 'widgets/page_dots.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;
    final imageHeight = MediaQuery.of(context).size.height * 0.52;
    const overlap = 30.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'article-img-${article.url}',
                  child: SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: article.imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: article.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey.shade300),
                            errorWidget: (_, __, ___) => Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.article,
                              size: 64,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),

                Positioned(
                  top: safeTop + 12,
                  left: 16,
                  child: OverlayButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => context.pop(),
                  ),
                ),

                Positioned(
                  top: safeTop + 12,
                  right: 16,
                  child: OverlayButton(
                    icon: Icons.bookmark_border_rounded,
                    onTap: () {},
                  ),
                ),

                Positioned(
                  bottom: overlap + 20,
                  left: 0,
                  right: 0,
                  child: const PageDots(),
                ),
              ],
            ),

            Transform.translate(
              offset: const Offset(0, -overlap),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
             
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A2E),
                        height: 1.25,
                        letterSpacing: -0.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            article.source,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatArticleDate(article.publishedAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '•',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Text(
                            readTime(article.description),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    if (article.description.isNotEmpty)
                      Text(
                        article.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3D3D3D),
                          height: 1.8,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
