import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/HomePage.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/FeatureBox.dart';
import 'package:pixel_pen/widgets/MainButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int start = 200;
  int delay = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        title: BounceInDown(
          delay: Duration(milliseconds: 800),
          duration: Duration(milliseconds: 2000),
          child: Container(
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
            // ZoomIn(
            //   child: Stack(
            //     children: [
            //       Center(
            //         child: Container(
            //           height: 130,
            //           width: 150,
            //           margin: const EdgeInsets.only(top: 4),
            //           decoration: const BoxDecoration(
            //             color: Colors.white,
            //             shape: BoxShape.rectangle,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         height: 130,
            //         decoration: const BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage(
            //               'assets/images/logo.png', // logo will be there
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            FadeInDown(
              child: Visibility(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
                    child: const FeatureBox(
                      color: Color.fromRGBO(165, 231, 244, 1),
                      headerText: 'H1',
                      descriptionText: 'A smarter way to stay organized',
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(milliseconds: start + delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(157, 202, 235, 1),
                      headerText: 'H2',
                      descriptionText: 'Get inspired and stay creative',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(102, 214, 237, 1),
                      headerText: 'H3',
                      descriptionText:
                          'A smarter way to stay organized and informed',
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(milliseconds: start + 3 * delay),
                    child: const FeatureBox(
                      color: Color.fromRGBO(162, 238, 239, 1),
                      headerText: 'H4',
                      descriptionText: 'Get the best',
                    ),
                  ),
                ],
              ),
            ),
            MainButton(
              child: const Text(
                "Pick Me",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.titleColor),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
