import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/article.dart';
import '../providers/news_providers.dart';

class NewsFeedViewModel extends AsyncNotifier<List<Article>> {
  @override
  Future<List<Article>> build() async {
    final useCase = ref.watch(getTopHeadlinesProvider);
    final (articles, error) = await useCase.call();

    if (error != null) throw error;
    return articles!;
  }

  Future<void> refresh() async => ref.invalidateSelf();
}

final newsFeedViewModelProvider =
    AsyncNotifierProvider<NewsFeedViewModel, List<Article>>(
  NewsFeedViewModel.new,
);
