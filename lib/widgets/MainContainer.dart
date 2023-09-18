import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';

class MainContainer extends StatefulWidget {
  final Widget child;
  final Color? color;
  final VoidCallback onPressed;
  const MainContainer(
      {Key? key, required this.child, required this.onPressed, this.color})
      : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainContainer> {
  bool _pressing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => _pressing = true),
      onTapUp: (value) => setState(() => _pressing = false),
      onTapCancel: () => setState(() => _pressing = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color:
                _pressing ? Colors.grey[350] : widget.color!.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _pressing
                ? [
                    BoxShadow(
                        color: widget.color!,
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                        spreadRadius: 1),
                    const BoxShadow(
                        color: Colors.white,
                        blurRadius: 6,
                        offset: Offset(-2, -2),
                        spreadRadius: 1),
                  ]
                : [
                    BoxShadow(
                        color: widget.color!,
                        blurRadius: 12,
                        offset: const Offset(4, 4),
                        spreadRadius: 1),
                    const BoxShadow(
                        color: Colors.white,
                        blurRadius: 12,
                        offset: Offset(-4, -4),
                        spreadRadius: 1),
                  ]),
        child: widget.child,
      ),
    );
  }
}
