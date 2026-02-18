import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/article.dart';
import '../providers/news_providers.dart';

class NewsFeedViewModel extends AsyncNotifier<List<Article>> {
  @override
  Future<List<Article>> build() async {
    final useCase = ref.watch(getTopHeadlinesProvider);
    final result = await useCase.call();

    switch (result) {
      case Success<List<Article>>(:final data):
        return data;
      case Failure<List<Article>>(:final exception):
        throw exception;
    }
  }

  Future<void> refresh() async => ref.invalidateSelf();
}

final newsFeedViewModelProvider =
    AsyncNotifierProvider<NewsFeedViewModel, List<Article>>(
  NewsFeedViewModel.new,
);
