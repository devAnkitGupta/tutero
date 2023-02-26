import 'package:flutter/cupertino.dart';

class CursorState {
  const CursorState({
    this.offset = Offset.zero,
    this.size = kDefaultSize,
  });

  static const Size kDefaultSize = Size(20, 20);
  final Offset offset;
  final Size size;
}

class ArrowNotifier {
  final ValueNotifier<CursorState> cursorState =
      ValueNotifier(const CursorState());

  void updateCursorPosition(Offset pos) {
    cursorState.value = CursorState(offset: pos);
  }
}
