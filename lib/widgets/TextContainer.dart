import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';

class TextContainer extends StatefulWidget {
  final String extractedText;
  const TextContainer({super.key, required this.extractedText});

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500, // Adjust the height as needed
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.backgroundColor!,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: AppColors.darkColor!,
                blurRadius: 12,
                offset: const Offset(4, 4),
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                blurRadius: 12,
                offset: Offset(-4, -4),
                spreadRadius: 1),
          ]), // Adjust the width as needed
      child: FadeIn(
        duration: const Duration(seconds: 8),
        child: SingleChildScrollView(child: Text(widget.extractedText)),
      ),
    );
  }
}
