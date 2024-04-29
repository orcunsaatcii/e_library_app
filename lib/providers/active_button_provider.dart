import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ActiveButton {
  books,
  magazines,
  freeBooks,
  paidBooks,
}

class ActiveButtonNotifier extends StateNotifier<ActiveButton> {
  ActiveButtonNotifier() : super(ActiveButton.books);

  void setActiveButton(ActiveButton button) {
    state = button;
  }
}

final activeButtonProvider =
    StateNotifierProvider<ActiveButtonNotifier, ActiveButton>((ref) {
  return ActiveButtonNotifier();
});
