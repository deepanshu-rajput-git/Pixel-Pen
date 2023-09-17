import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/ImageScanner.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/PdfScanner.dart';
import 'package:pixel_pen/widgets/TextScanner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
        ),
      ),
    );
  }

  final pages = [
    Container(
      color: AppColors.mainColor2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Builder(
                builder: (context) => MainButton(
                  child: const Text(
                    "PixelPen intuitively detects the language of your PDF, ensuring accurate text conversion.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.titleColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PdfScanner(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child:
                  Lottie.asset('assets/pdfPage.json', width: 350, height: 450),
            ),
          ],
        ),
      ),
    ),
    Container(
      color: AppColors.mainColor4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Builder(
              builder: (context) => MainButton(
                child: const Text(
                  "Image Processing",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.titleColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImageScanner(),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child:
                Lottie.asset('assets/lastPage.json', width: 350, height: 350),
          ),
        ],
      ),
    ),
    Container(
      color: AppColors.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // color: Color.fromARGB(255, 210, 242, 68),
            child: Builder(
              builder: (context) => MainButton(
                child: const Text(
                  "Camera Processing",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.titleColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextScanner(),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child:
                Lottie.asset('assets/imagePage.json', width: 300, height: 250),
          ),
        ],
      ),
    ),
    Container(
      color: AppColors.mainColor3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child:
                Lottie.asset('assets/developer.json', width: 300, height: 250),
          ),
        ],
      ),
    ),
  ];
}
