
import 'package:flutter/material.dart';
import 'package:tutero/particles/ui/particle_view.dart';
import 'package:tutero/player/notifier/notifier.dart';
import 'package:tutero/player/ui/player.dart';

class MyGalaxy extends StatefulWidget {
  const MyGalaxy({super.key});

  @override
  State<MyGalaxy> createState() => _MyGalaxyState();
}

class _MyGalaxyState extends State<MyGalaxy> {
  ArrowNotifier notifier = ArrowNotifier();
  final GlobalKey _playerKey = GlobalKey();

  void _updatePosition(PointerEvent event) {
    notifier.updateCursorPosition(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: _updatePosition,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: _getChildrens(),
        ),
      ),
    );
  }

  List<Widget> _getChildrens() => [
        Player(key: _playerKey, notifier: notifier),
        ParticleScreen(
          playerKey: _playerKey,
          onGameOver: () {
            Navigator.pop(context);
          },
        ),
      ];
}
