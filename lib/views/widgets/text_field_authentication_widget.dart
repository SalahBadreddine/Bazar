import 'package:bazar/constants/app_colors.dart';
import 'package:bazar/constants/ktext_styles.dart';
import 'package:flutter/material.dart';

class TextFieldAuthenticationWidget extends StatefulWidget {
  const TextFieldAuthenticationWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.isPassword,
    this.prefixIcon,
  });

  final String title;
  final String hintText;
  final bool isPassword;
  final Widget? prefixIcon;

  @override
  State<TextFieldAuthenticationWidget> createState() =>
      _TextFieldAuthenticationWidgetState();
}

class _TextFieldAuthenticationWidgetState
    extends State<TextFieldAuthenticationWidget> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: KtextStyles.bodymedium14),
        SizedBox(height: 8),
        TextFormField(
          obscureText: widget.isPassword ? hidePassword : false,
          style: KtextStyles.bodymedium16,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() {
                      hidePassword = !hidePassword;
                    }),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.greyscale500,
                      size: 24,
                    ),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: KtextStyles.bodyregular16,
            filled: true,
            fillColor: AppColors.greyscale50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
