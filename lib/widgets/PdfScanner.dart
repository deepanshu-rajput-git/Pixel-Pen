import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/TextContainer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

class PdfScanner extends StatefulWidget {
  const PdfScanner({Key? key}) : super(key: key);

  @override
  State<PdfScanner> createState() => _PdfScannerState();
}

class _PdfScannerState extends State<PdfScanner> {
  String? extractedText;

  Future<void> extractTextFromPDF() async {
    try {
      // Show a file picker dialog to select a PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File pdfFile = File(result.files.single.path!);

        // Load the selected PDF document
        final PdfDocument document = PdfDocument(
          inputBytes: pdfFile.readAsBytesSync(),
        );

        // Extract text from all the pages
        String text = PdfTextExtractor(document).extractText();

        // Dispose of the document to free up resources
        document.dispose();

        // Update the state to display the extracted text
        setState(() {
          extractedText = text;
        });
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      print('Error: $e');
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
              MainButton(
                child: const Text(
                  "Press Me to Pick for PDF extraction",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.titleColor),
                ),
                onPressed: () {
                  extractTextFromPDF();
                },
              ),
              extractedText != null
                  ? TextContainer(extractedText: extractedText!)
                  : Container(),
              extractedText != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainButton(
                          child: const Text(
                            "Save to drive",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.titleColor),
                          ),
                          onPressed: () {
                            // To Do Save to drive
                          },
                        ),
                        MainButton(
                          child: const Text(
                            "Download",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.titleColor),
                          ),
                          onPressed: () {
                            // To do Shared Prefernces
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        )));
  }
}
