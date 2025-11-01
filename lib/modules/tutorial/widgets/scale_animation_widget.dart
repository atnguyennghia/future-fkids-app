import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  final Widget? child;

  const ScaleAnimationWidget({Key? key, this.child}) : super(key: key);

  @override
  State<ScaleAnimationWidget> createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with TickerProviderStateMixin {
  Animation? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(
      begin: 0.8,
      end: 1.0,
    ).animate(_animationController!);

    _animationController?.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animationController?.repeat(reverse: true);
      }
    });

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation?.value,
          child: widget.child,
        );
      },
    );
  }
}
