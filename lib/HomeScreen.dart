import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/ImageScanner.dart';
import 'package:pixel_pen/widgets/MainContainer.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Lottie.asset('assets/pdfPage.json', width: 350, height: 450),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            child: Builder(
              builder: (context) => MainContainer(
                color: AppColors.mainColor2,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PdfScanner(),
                    ),
                  );
                },
                child: const Text(
                  "Your PDFs, Your Words :\n PixelPen at Your Service...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Swipe...",
            style: TextStyle(
                fontFamily: 'Cera Pro',
                color: AppColors.titleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
    Container(
      color: AppColors.mainColor4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child:
                Lottie.asset('assets/lastPage.json', width: 400, height: 350),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            child: Builder(
              builder: (context) => MainContainer(
                color: AppColors.mainColor4,
                child: const Text(
                  "Unlock Text from Pixels :\n PixelPen - Your Digital Ink..!",
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Swipe...",
            style: TextStyle(
                fontFamily: 'Cera Pro',
                color: AppColors.titleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
    Container(
      color: AppColors.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child:
                Lottie.asset('assets/imagePage.json', width: 300, height: 250),
          ),
          const SizedBox(
            height: 160,
          ),
          Container(
            // color: Color.fromARGB(255, 210, 242, 68),
            child: Builder(
              builder: (context) => MainContainer(
                color: AppColors.mainColor,
                child: const Text(
                  "Unlock Text from Your Lens :\n PixelPen's Text Extraction Magic...",
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Swipe...",
            style: TextStyle(
                fontFamily: 'Cera Pro',
                color: AppColors.titleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
    Container(
      color: AppColors.mainColor3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child:
                Lottie.asset('assets/developer.json', width: 350, height: 300),
          ),
          const SizedBox(
            height: 200,
          ),
          const Text(
            'Developed With ❤️ \n    By Deepanshu and Vishal Manam',
            style: TextStyle(
              fontFamily: 'Cera Pro',
              color: AppColors.titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    ),
  ];
}
