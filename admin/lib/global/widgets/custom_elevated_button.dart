import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.text,
    this.onPressed,
    this.primary,
    this.fontSize,
    this.textColor,
    this.onPrimary,
    this.onSurface,
    this.width,
    this.height,
  }) : super(key: key);
  final String? text;
  final VoidCallback? onPressed;
  final Color? primary;
  final double? fontSize;
  final Color? textColor;
  final Color? onPrimary;
  final Color? onSurface;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        primary: primary ?? Theme.of(context).colorScheme.primaryContainer,
        onPrimary:
            onPrimary ?? Theme.of(context).colorScheme.onPrimaryContainer,
        onSurface: onSurface,
        minimumSize: Size(
          width ?? 100.w,
          height ?? 8.h,
        ),
      ),
      child: DText(
        text: text,
        fontSize: fontSize,
        textColor:
            textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
