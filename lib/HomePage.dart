import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pixel_pen/widgets/PdfScanner.dart';
import 'package:pixel_pen/widgets/ResultScreen.dart';
import 'package:pixel_pen/widgets/TextScanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilePickerResult? filePicked; // pdf file picked
  String? selectedFileName;
  String? imagePath;
  final textRecogniser = TextRecognizer();
  String? outputText;
  // Function to pick a image file
  Future<void> pickPDFFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String? path = file.path;
        // print("BadBoy---------");
        // print(path);
        // Update the UI with the selected file name
        setState(() {
          selectedFileName = fileName;
          filePicked = result;
          imagePath = path;
        });
      }
    } catch (e) {
      print("Error picking image : $e");
    }
  }

  //It will take care of scanning text from image
  Future<void> scanImage() async {
    // if (cameraController == null) {
    //   return;
    // }
    final navigator = Navigator.of(context);
    try {
      // final pictureFile = await cameraController!.takePicture();
      final file = File(imagePath!);
      final inputImage = InputImage.fromFile(file);
      final recognizerText = await textRecogniser.processImage(inputImage);
      setState(() {
        outputText = recognizerText.text;
      });
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizerText.text),
        ),
      );
      // print(outputText);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: const Text(
            'An error occurred when scanning text',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Customize the text color
            ),
          ),
          backgroundColor:
              AppColors.mainColor, // Customize the background color
          duration: const Duration(seconds: 5), // Adjust the duration as needed
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            textColor: Colors.white, // Customize the action button text color
          ),
        ),
      );
    }
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 100 / 2,
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
                    child: Center(
                      child: FadeIn(
                        duration: const Duration(seconds: 2),
                        child: Text(
                          selectedFileName != null
                              ? 'Selected Image :   $selectedFileName'
                              : "Please pick any image",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainButton(
                    child: const Text(
                      "Browse Me",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.titleColor),
                    ),
                    onPressed: () {
                      pickPDFFile();
                    },
                  ),
                  MainButton(
                    child: const Text(
                      "Camera",
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
                ],
              ),
              MainButton(
                child: const Text(
                  "Press Me to Pick for PDF extraction",
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
              ),
              filePicked != null
                  ? Container(
                      height: 250, // Adjust the height as needed
                      width: 250,
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
                        child: Image.file(
                          File(imagePath!),
                        ),
                      ))
                  : Container(),
              // const MyProgressIndicator(progress: 0.1),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainButton(
                    child: const Text(
                      "Process Me",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.titleColor),
                    ),
                    onPressed: () {
                      scanImage();
                    },
                  ),
                  MainButton(
                    child: const Row(
                      children: [
                        Text(
                          "Copy ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.titleColor),
                        ),
                        Icon(
                          Icons.copy,
                          color: AppColors.titleColor,
                          size: 18, // Adjust the icon color as needed
                        ),
                      ],
                    ),
                    onPressed: () {
                      try {
                        if (outputText!.trim() != "") {
                          FlutterClipboard.copy(outputText!).then((value) {
                            // Show a message or perform any other actions after copying
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                dismissDirection: DismissDirection.horizontal,
                                content: const Text(
                                  'Text Copied to Clipboard ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // Customize the text color
                                  ),
                                ),
                                backgroundColor: Colors.limeAccent[
                                    700], // Customize the background color
                                duration: const Duration(
                                    seconds:
                                        5), // Adjust the duration as needed
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                  textColor: Colors
                                      .white, // Customize the action button text color
                                ),
                              ),
                            );
                          });
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            dismissDirection: DismissDirection.horizontal,
                            content: const Text(
                              'Please upload Image and process it',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Customize the text color
                              ),
                            ),
                            backgroundColor: AppColors
                                .mainColor, // Customize the background color
                            duration: const Duration(
                                seconds: 5), // Adjust the duration as needed
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                              textColor: Colors
                                  .white, // Customize the action button text color
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              // outputText != null
              //     ? TextContainer(extractedText: outputText!)
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
