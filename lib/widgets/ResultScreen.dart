import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixel_pen/utils/showSnackBar.dart';
import 'package:pixel_pen/widgets/MainButton.dart';
import 'package:pixel_pen/widgets/TextContainer.dart';
import '../utils/colors.dart';

class ResultScreen extends StatefulWidget {
  final String text;
  final String name;
  const ResultScreen({Key? key, required this.text, required this.name})
      : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _downloadsPath = 'Unknown';

  @override
  void initState() {
    super.initState();
    initDownloadsDirectoryPath();
  }

  Future<void> initDownloadsDirectoryPath() async {
    String downloadsPath;
    try {
      downloadsPath = (await DownloadsPath.downloadsDirectory())?.path ??
          "Downloads path doesn't exist";
    } catch (e) {
      downloadsPath = 'Failed to get downloads paths';
    }

    if (!mounted) return;

    setState(() {
      _downloadsPath = downloadsPath;
    });
  }

  Future<void> _downloadTextAsFile(BuildContext context, text) async {
    final downloadsDirectory = await DownloadsPath.downloadsDirectory();
    final fileName = widget.name;
    final filePath = '${downloadsDirectory?.path}/$fileName.txt';

    final file = File(filePath);
    await file.writeAsString(text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Text Downloaded to Your Device',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.limeAccent[700],
        duration: const Duration(seconds: 5),
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

  Future<void> _saveTextToDrive(BuildContext context, String text) async {
    // TO DO:
    // Implement the logic to save the text to Google Drive here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Feature not available yet',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _startDownload() async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        await _downloadTextAsFile(context, widget.text);
      } catch (e) {
        // Handle any potential errors here
        showErrorSnackbar(context, 'Error during download');
      }
    } else {
      // Handle the case where the user denies storage permission
      showErrorSnackbar(context, 'Storage permission denied');
    }
  }

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
                if (widget.text.trim() != "") {
                  FlutterClipboard.copy(widget.text).then((value) {
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
              TextContainer(extractedText: widget.text),
              Row(
                children: [
                  MainButton(
                    child: Text("Download"),
                    onPressed: () {
                      _startDownload();
                    },
                  ),
                  MainButton(
                      child: Text("Save to Drive"),
                      onPressed: () {
                        _saveTextToDrive(context, widget.text);
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
