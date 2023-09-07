import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:pixel_pen/utils/colors.dart';

class MyProgressIndicator extends StatefulWidget {
  final double progress;
  const MyProgressIndicator({Key? key, required this.progress})
      : super(key: key);

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the animationController with the widget's progress value
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
      value: widget.progress, // Initialize with the widget's progress value
    );

    animationController.addListener(() {
      setState(() {});
    });

    // animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;
    return Container(
      width: double.infinity,
      height: 75,
      // padding: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.darkColor!,
            blurRadius: 6,
            offset: const Offset(2, 2),
            spreadRadius: 1),
        const BoxShadow(
            color: Colors.white,
            blurRadius: 6,
            offset: Offset(-2, -2),
            spreadRadius: 1),
      ]),
      child: LiquidLinearProgressIndicator(
        borderRadius: 20.0,
        value: animationController.value,
        valueColor: AlwaysStoppedAnimation(Colors.amber),
        center: Text(
          '${percentage.toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        direction: Axis.horizontal,
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}
