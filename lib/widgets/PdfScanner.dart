import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/ResultScreen.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/showSnackBar.dart';

class PdfScanner extends StatefulWidget {
  const PdfScanner({Key? key}) : super(key: key);

  @override
  State<PdfScanner> createState() => _PdfScannerState();
}

class _PdfScannerState extends State<PdfScanner> {
  FilePickerResult? filePicked; // pdf file picked
  String? extractedText;
  String? selectedFileName;
  String? pdfPath;

  Future<void> extractTextFromPDF() async {
    try {
      // Show a file picker dialog to select a PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        String? path = file.path;
        File pdfFile = File(result.files.single.path!);

        // Load the selected PDF document
        final PdfDocument document = PdfDocument(
          inputBytes: pdfFile.readAsBytesSync(),
        );

        // Extract text from all the pages
        String text = PdfTextExtractor(document).extractText();

        // Dispose of the document to free up resources
        document.dispose();

        // Updating the state to display the extracted text
        setState(() {
          extractedText = text;
          selectedFileName = fileName;
          filePicked = result;
          pdfPath = path;
        });
      }
    } catch (e) {
      showErrorSnackbar(context, 'An error occurred when scanning PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        backgroundColor: AppColors.backgroundColor,
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
                              ? 'Selected PDF :   $selectedFileName'
                              : "Please pick any PDF",
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              MainButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Pick PDF for extraction",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.titleColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.open_in_browser_rounded,
                      size: 27,
                    )
                  ],
                ),
                onPressed: () {
                  extractTextFromPDF();
                },
              ),
              filePicked != null
                  ? Container(
                      height: 350,
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
                      child: SfPdfViewer.file(
                        File(pdfPath!),
                        maxZoomLevel: 5,
                        enableDoubleTapZooming: true,
                      ),
                    )
                  : Container(),
              // const MyProgressIndicator(progress: 0.1),
              extractedText != null
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
                              'Extracting text from PDF..',
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
                                text: extractedText!, name: selectedFileName!),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Lottie.asset('assets/pdfAni.json',
                          width: 350, height: 400),
                    ), // animation
            ],
          ),
        )));
  }
}
