import 'package:flutter/material.dart';

class MainIconButton extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  final int size;
  final Color? iconColor;

  const MainIconButton({
    Key? key,
    required this.icon,
    required this.onClick,
    required this.size,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size * 1.0,
      width: size * 1.0,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Color(0x66aeaec0),
            offset: Offset(3, 3),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x80ffffff),
            offset: Offset(-3, -3),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
        color: Color(0xffeaeaea),
      ),
      child: TextButton(
        onPressed: () {
          onClick();
        },
        child: Icon(
          icon,
          size: size / 2,
          color: iconColor ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
