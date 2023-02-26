import 'package:flutter/material.dart';
import 'package:tutero/particles/model/particle.dart';
import 'dart:math';

class ParticleScreen extends StatefulWidget {
  const ParticleScreen({
    Key? key,
    required this.playerKey,
    required this.onGameOver,
  }) : super(key: key);

  final GlobalKey playerKey;
  final VoidCallback onGameOver;

  @override
  State<ParticleScreen> createState() => _ParticleScreenState();
}

class _ParticleScreenState extends State<ParticleScreen>
    with SingleTickerProviderStateMixin {
  final List<Particle> _particles = [];
  final Random _random = Random();
  late GlobalKey _playerKey;

  static const _minSize = 10.0;
  static const _maxSize = 50.0;
  static const _numParticles = 50;
  static const _avgSpeed = 50.0;
  static const _startingX = 0.0;
  static const _startingY = 0.0;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _playerKey = widget.playerKey;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playerKey = widget.playerKey;

    for (int i = 0; i < _numParticles; i++) {
      _particles.add(_createParticle());
    }
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        _updateParticles();
        _checkCollisions();
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
          setState(() {});
        }
      });
    _controller.forward();
    setState(() {});
  }

  Particle _createParticle() {
    double x =
        _startingX + _random.nextDouble() * MediaQuery.of(context).size.width;
    double y =
        _startingY + _random.nextDouble() * MediaQuery.of(context).size.height;
    double size = _random.nextDouble() * (_maxSize - _minSize) + _minSize;
    double dx = (_random.nextDouble() - 0.5) * _avgSpeed * 2;
    double dy = (_random.nextDouble() - 0.5) * _avgSpeed * 2;
    return Particle(x: x, y: y, size: size, dx: dx, dy: dy);
  }

  Widget _buildParticle(Particle particle) {
    return Positioned(
      left: particle.x,
      top: particle.y,
      child: Container(
        width: particle.size,
        height: particle.size,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _updateParticles() {
    for (int i = 0; i < _particles.length; i++) {
      Particle particle = _particles[i];
      particle.x += particle.dx * _animation.value;
      particle.y += particle.dy * _animation.value;
      if (particle.x < -particle.size ||
          particle.y < -particle.size ||
          particle.x > MediaQuery.of(context).size.width + particle.size ||
          particle.y > MediaQuery.of(context).size.height + particle.size) {
        _particles[i] = _createParticle();
      }
    }
  }

  void _checkCollisions() {
    final playerBox =
        _playerKey.currentContext?.findRenderObject() as RenderBox?;

    for (Particle particle in _particles) {
      final particleBox =
          Rect.fromLTWH(particle.x, particle.y, particle.size, particle.size);

      if (playerBox != null && particleBox.overlaps(playerBox.paintBounds)) {
        _gameOver();
        break;
      }
    }
  }

  void _gameOver() {
    _controller.stop();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        content: const Text('You collided with a particle!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onGameOver.call();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _particles.map((particle) => _buildParticle(particle)).toList(),
    );
  }
}
