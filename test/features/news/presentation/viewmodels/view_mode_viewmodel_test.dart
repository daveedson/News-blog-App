import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_blog_app/features/news/presentation/viewmodels/view_mode_viewmodel.dart';

void main() {
  group('ViewModeNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is ViewMode.list', () {
      expect(container.read(viewModeProvider), ViewMode.list);
    });

    test('toggle switches from list to grid', () {
      container.read(viewModeProvider.notifier).toggle();
      expect(container.read(viewModeProvider), ViewMode.grid);
    });

    test('toggle twice returns to list', () {
      container.read(viewModeProvider.notifier).toggle();
      container.read(viewModeProvider.notifier).toggle();
      expect(container.read(viewModeProvider), ViewMode.list);
    });

    test('toggle alternates state on each call', () {
      final notifier = container.read(viewModeProvider.notifier);

      notifier.toggle();
      expect(container.read(viewModeProvider), ViewMode.grid);

      notifier.toggle();
      expect(container.read(viewModeProvider), ViewMode.list);

      notifier.toggle();
      expect(container.read(viewModeProvider), ViewMode.grid);
    });
  });
}
