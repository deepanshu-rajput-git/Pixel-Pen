import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double width;
  final String text;
  final bool loading;
  final Function onClick;

  const MainButton({
    Key? key,
    required this.width,
    required this.text,
    required this.loading,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
        child: loading
            ? CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ),
              ),
      ),
    );
  }
}
