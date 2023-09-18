import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/HomeScreen.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/FeatureBox.dart';
import 'package:pixel_pen/widgets/MainButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int start = 50;
  int delay = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        title: BounceInDown(
          delay: const Duration(milliseconds: 800),
          duration: const Duration(milliseconds: 2000),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor!,
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
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Text(
                'Pixel Pen',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: AppColors.titleColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeIn(
              child: Visibility(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ), //
                  margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                    top: 30,
                  ),
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
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Your PDFs, Your Words: Conversion Revolutionized",
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: AppColors.titleColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SlideInLeft(
              child: Visibility(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 22),
                  child: const Text(
                    'Here are a few features',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: AppColors.titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // features list
            Visibility(
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: FeatureBox(
                      color: AppColors.mainColor3.withOpacity(1),
                      headerText: 'Preserve Text Formatting',
                      descriptionText:
                          'PixelPen maintains the original text formatting, ensuring your Word file looks just like the PDF.',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: FeatureBox(
                      color: AppColors.mainColor.withOpacity(1),
                      headerText: 'Effortless PDF-to-Word Conversion',
                      descriptionText:
                          'PixelPen intuitively detects the language of your PDF, ensuring accurate text conversion.',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 3 * delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(102, 214, 237, 1),
                      headerText: 'Privacy and Security',
                      descriptionText:
                          'Your PDFs are handled with care. PixelPen deletes them from the server after processing.',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 4 * delay),
                    child: FeatureBox(
                      color: AppColors.mainColor2.withOpacity(0.9),
                      headerText: 'Efficient Batch Processing',
                      descriptionText:
                          'Batch process multiple files at once, saving you time and effort.Easily view and download the processed Word files to your local device for convenience.',
                    ),
                  ),
                ],
              ),
            ),
            MainButton(
              child: const Text(
                "Let's Explore..",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.titleColor),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
