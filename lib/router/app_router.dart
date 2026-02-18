import 'package:go_router/go_router.dart';
import '../features/news/domain/entities/article.dart';
import '../features/news/presentation/views/article_detail_screen.dart';
import '../features/news/presentation/views/news_feed_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/news',
  routes: [
    GoRoute(
      path: '/news',
      builder: (context, state) => const NewsFeedScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) => ArticleDetailScreen(
            article: state.extra as Article,
          ),
        ),
      ],
    ),
  ],
);
