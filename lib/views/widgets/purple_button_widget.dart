import 'package:bazar/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PurpleButtonWidget extends StatelessWidget {
  const PurpleButtonWidget({super.key, required this.text, this.isSwitched = false});
  final String text;
  final bool isSwitched;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: isSwitched ? AppColors.primary50 : AppColors.primary500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSwitched ? AppColors.primary500: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
