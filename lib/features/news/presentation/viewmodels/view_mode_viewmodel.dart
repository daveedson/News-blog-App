import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewMode { list, grid }

class ViewModeNotifier extends Notifier<ViewMode> {
  @override
  ViewMode build() => ViewMode.list;

  void toggle() {
    state = state == ViewMode.list ? ViewMode.grid : ViewMode.list;
  }
}

final viewModeProvider = NotifierProvider<ViewModeNotifier, ViewMode>(
  ViewModeNotifier.new,
);
