import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_pen/SplashPage.dart';
import 'package:pixel_pen/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure whether the dependencies are loaded correctly
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel Pen',
      theme: ThemeData(
          primaryColor: AppColors.mainColor,
          secondaryHeaderColor: AppColors.mainColor2,
          scaffoldBackgroundColor: AppColors.mainColor),
      home: SplashScreen(),
      // home: ResultScrSeen(text: "Hello Deepanshu"),
      // home: PdfScanner(),
    );
  }
}
