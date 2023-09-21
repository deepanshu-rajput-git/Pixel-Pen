import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/ResultScreen.dart';

import '../utils/colors.dart';
import '../utils/showSnackBar.dart';

class ImageScanner extends StatefulWidget {
  const ImageScanner({super.key});

  @override
  State<ImageScanner> createState() => _ImageScannerState();
}

class _ImageScannerState extends State<ImageScanner> {
  FilePickerResult? filePicked; // image file picked
  String? selectedFileName;
  String? imagePath;
  final textRecogniser = TextRecognizer();
  String? outputText;
  // Function to pick a image file
  Future<void> pickImageFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String? path = file.path;
        File pickedImage = File(path!);
        final inputImage = InputImage.fromFile(pickedImage);
        final recognizerText = await textRecogniser.processImage(inputImage);
        // print("BadBoy---------");
        // print(path);
        // Update the UI with the selected file name

        setState(() {
          selectedFileName = fileName;
          filePicked = result;
          imagePath = path;
          outputText = recognizerText.text;
        });
      }
    } catch (e) {
      showErrorSnackbar(context, 'Image not Picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const MyAppBar(),
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
                              ? 'Selected Image :  $selectedFileName'
                              : "Please pick any image...",
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Pick Image for extraction",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.titleColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.image_outlined,
                          size: 27,
                        )
                      ],
                    ),
                    onPressed: () {
                      pickImageFile();
                      // scanImage();// need to implement picking and scanning in one  fxn pnly likewise pdf case
                    },
                  ),
                ],
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
                  : Center(
                      child: Lottie.asset('assets/imageAni.json',
                          width: 300, height: 450),
                    ),
              // const MyProgressIndicator(progress: 0.1),
              outputText != null
                  ? MainButton(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Process Me",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.titleColor),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 30,
                          )
                        ],
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            dismissDirection: DismissDirection.horizontal,
                            content: const Text(
                              'Extracting text from image..',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Customize the text color
                              ),
                            ),
                            backgroundColor: AppColors.mainColor2,
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                              textColor: Colors.white,
                            ),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                text: outputText!, name: selectedFileName!),
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
