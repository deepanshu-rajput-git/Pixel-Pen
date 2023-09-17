import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:pixel_pen/widgets/ImageScanner.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/PdfScanner.dart';
import 'package:pixel_pen/widgets/TextScanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                MainButton(
                    child: const Text(
                      "Image Processing",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.titleColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImageScanner()));
                    }),
                MainButton(
                  child: const Text(
                    "Camera Processing",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.titleColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TextScanner()));
                  },
                ),
                MainButton(
                  child: const Text(
                    "PDF Processing",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.titleColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PdfScanner()));
                  },
                )
              ]),
        ),
      ),
    );
  }
}
