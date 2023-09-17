import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';

void showErrorSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Customize the text color
        ),
      ),
      backgroundColor: AppColors.mainColor, // Customize the background color
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
