import 'package:flutter/material.dart';

class RotatingChevronIcon extends StatefulWidget {
  const RotatingChevronIcon({super.key, required this.isExpanded});
  final bool isExpanded;
  @override
  State<RotatingChevronIcon> createState() => _RotatingChevronIconState();
}

class _RotatingChevronIconState extends State<RotatingChevronIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.25)
        .chain(CurveTween(curve: Curves.easeInOut)));
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant RotatingChevronIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: const Icon(Icons.chevron_right_outlined),
    );
  }
}
