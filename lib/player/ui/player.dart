import 'package:flutter/material.dart';
import 'package:tutero/player/notifier/notifier.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  final ArrowNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CursorState>(
      valueListenable: notifier.cursorState,
      builder: (context, state, snapshot) {
        return Positioned(
          left: state.offset.dx - state.size.width / 2,
          top: state.offset.dy - state.size.height / 2,
          width: state.size.width,
          height: state.size.height,
          child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
