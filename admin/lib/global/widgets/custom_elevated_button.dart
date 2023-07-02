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
    this.fontWeight,
    this.height,
    this.borderRadius,
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
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        backgroundColor:
            primary ?? Theme.of(context).colorScheme.primaryContainer,
        foregroundColor:
            onPrimary ?? Theme.of(context).colorScheme.onPrimaryContainer,
        disabledForegroundColor: onSurface,
        minimumSize: Size(
          width ?? 100.w,
          height ?? 8.h,
        ),
      ),
      child: DText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        textColor:
            textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
