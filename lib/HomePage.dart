import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:file_picker/file_picker.dart';
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
    // final navigator = Navigator.of(context);
    try {
      // final pictureFile = await cameraController!.takePicture();
      final file = File(imagePath!);
      final inputImage = InputImage.fromFile(file);
      final recognizerText = await textRecogniser.processImage(inputImage);
      setState(() {
        outputText = recognizerText.text;
      });
      // print(outputText);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
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
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle, // Use a circular shape for the button
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
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
                        duration: Duration(seconds: 2),
                        child: Text(
                          selectedFileName != null
                              ? 'Selected Image :   $selectedFileName'
                              : "No File Choosen",
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
                      "Pick Me",
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
                              builder: (context) => TextScanner()));
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
                        duration: Duration(seconds: 8),
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
                    child: const Text(
                      "Copy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.titleColor),
                    ),
                    onPressed: () {
                      //TO DO Download file to local device
                    },
                  ),
                ],
              ),
              outputText != null
                  ? Container(
                      height: 200, // Adjust the height as needed
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                        duration: Duration(seconds: 8),
                        child: SingleChildScrollView(child: Text(outputText!)),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
