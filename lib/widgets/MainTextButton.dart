import 'package:flutter/material.dart';

class MainTextButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final bool loading;

  const MainTextButton({
    Key? key,
    required this.text,
    required this.onClick,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}
