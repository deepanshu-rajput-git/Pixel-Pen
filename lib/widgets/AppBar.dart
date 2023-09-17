import 'package:flutter/material.dart';
import 'package:pixel_pen/utils/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;

  const MyAppBar({
    Key? key,
    required this.title,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
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
            iconSize: 24,
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.darkColor,
            ),
            onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cera Pro',
          color: AppColors.titleColor,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
