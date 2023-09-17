import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pixel_pen/widgets/AppBar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

class PdfScanner extends StatefulWidget {
  const PdfScanner({Key? key}) : super(key: key);

  @override
  State<PdfScanner> createState() => _PdfScannerState();
}

class _PdfScannerState extends State<PdfScanner> {
  String extractedText = '';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                extractTextFromPDF();
              },
              child: Text('Select PDF and Extract Text'),
            ),
            SizedBox(height: 20),
            if (extractedText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    extractedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
