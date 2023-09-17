import 'package:animate_do/animate_do.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/TextContainer.dart';

import '../utils/colors.dart';
// import 'package:flutter_clipboard/flutter_clipboard.dart'; // Import the clipboard package

class ResultScreen extends StatelessWidget {
  final String text;
  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                shape:
                    BoxShape.rectangle, // Use a circular shape for the button
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkColor!,
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 12,
                    offset: Offset(-4, -4),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                iconSize: 24, // Set the desired icon size
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.darkColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          title: BounceInDown(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 2000),
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
          actions: [
            IconButton(
              onPressed: () {
                // Check if the text is not empty before copying to the clipboard
                if (text.trim() != "") {
                  FlutterClipboard.copy(text).then((value) {
                    // Show a message or perform any other actions after copying
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        dismissDirection: DismissDirection.horizontal,
                        content: const Text(
                          'Text Copied to Clipboard ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Customize the text color
                          ),
                        ),
                        backgroundColor: Colors
                            .limeAccent[700], // Customize the background color
                        duration: const Duration(
                            seconds: 5), // Adjust the duration as needed
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          textColor: Colors
                              .white, // Customize the action button text color
                        ),
                      ),
                    );
                  });
                }
              },
              icon: const Icon(
                Icons.copy,
                color: AppColors.titleColor, // Adjust the icon color as needed
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextContainer(extractedText: text),
              MainButton(child: Text("Copy the text"), onPressed: () {}),
              Row(
                children: [
                  MainButton(child: Text("Download"), onPressed: () {}),
                  MainButton(child: Text("Save to Drive"), onPressed: () {}),
                ],
              )
            ],
          ),
        ));
  }
}
