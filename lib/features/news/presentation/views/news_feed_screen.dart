import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/news_feed_viewmodel.dart';
import '../viewmodels/view_mode_viewmodel.dart';
import 'widgets/article_grid_item.dart';
import 'widgets/error_widget.dart';
import 'widgets/featured_article_card.dart';
import 'widgets/loading_widget.dart';
import 'widgets/short_article_card.dart';

class NewsFeedScreen extends ConsumerWidget {
  const NewsFeedScreen({super.key});

  static const _primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF3D8BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const _accentColor = Color(0xFF6C63FF);

  String _formattedDate() {
    final now = DateTime.now();
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsFeedViewModelProvider);
    final viewMode = ref.watch(viewModeProvider);
    final isGrid = viewMode == ViewMode.grid;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: newsAsync.when(
          data: (articles) {
            final featured = articles.take(5).toList();
            final shortForYou = articles.skip(5).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      // Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/newFace.png',
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: _primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Greeting
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formattedDate(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ── Search bar + search button ───────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for article...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Search button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: _primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: SvgPicture.asset(
                            'assets/svg/search.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // ── Content ─────────────────────────────────────────────
                if (isGrid)
                  // Grid view: all articles
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                          ),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return ArticleGridItem(
                          article: articles[index],
                          onTap: () => context.push(
                            '/news/detail',
                            extra: articles[index],
                          ),
                        );
                      },
                    ),
                  )
                else ...[
                  // ── Featured articles ─────────────────────────────────
                  SizedBox(
                    height: 278,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: featured.length,
                      itemBuilder: (context, index) {
                        final cardWidth =
                            MediaQuery.of(context).size.width - 56;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: cardWidth,
                            child: FeaturedArticleCard(
                              article: featured[index],
                              onTap: () => context.push(
                                '/news/detail',
                                extra: featured[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Short For You header ──────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Short For You',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 13,
                              color: _accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Short For You cards ───────────────────────────────
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: shortForYou.length,
                      itemBuilder: (context, index) {
                        return ShortArticleCard(
                          article: shortForYou[index],
                          onTap: () => context.push(
                            '/news/detail',
                            extra: shortForYou[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
          loading: () => const LoadingWidget(),
          error: (error, stack) => NewsErrorWidget(
            message: error.toString(),
            onRetry: () =>
                ref.read(newsFeedViewModelProvider.notifier).refresh(),
          ),
        ),
      ),

      // ── Toggle FAB ───────────────────────────────────────────────────
      floatingActionButton: GestureDetector(
        onTap: () => ref.read(viewModeProvider.notifier).toggle(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: _primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _accentColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              isGrid ? Icons.list_rounded : Icons.grid_view_rounded,
              key: ValueKey(isGrid),
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _accentColor,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 8,
        currentIndex: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: const Text('1'),
              child: const Icon(Icons.notifications_none),
            ),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
