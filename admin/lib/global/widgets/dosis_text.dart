import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DText extends StatelessWidget {
  static List<double> fontSizes = [
    12.sp,
    13.sp,
    14.sp,
    15.sp,
    16.sp,
    17.sp,
    18.sp,
    19.sp,
    20.sp,
    21.sp,
    22.sp,
    23.sp,
    24.sp,
    25.sp,
    26.sp,
    27.sp,
    28.sp,
    29.sp,
    30.sp,
    31.sp,
    32.sp,
    33.sp,
    34.sp,
    35.sp,
    36.sp,
    37.sp,
    38.sp,
    39.sp,
    40.sp,
  ];
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final bool? wrapWords;
  final bool? softWrap;
  final Widget? overFlowReplacement;
  final double? minFontSize;

  const DText({
    Key? key,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textDecoration,
    this.wrapWords,
    this.softWrap,
    this.overFlowReplacement,
    this.minFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.dosis(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor ?? Theme.of(context).colorScheme.onBackground,
        decoration: textDecoration,
      ),

      softWrap: softWrap ?? true,
      //wrapWords: false,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class ResponsiveDText extends StatelessWidget {
  static List<double> fontSizes = [
    12.sp,
    13.sp,
    14.sp,
    15.sp,
    16.sp,
    17.sp,
    18.sp,
    19.sp,
    20.sp,
    21.sp,
    22.sp,
    23.sp,
    24.sp,
    25.sp,
    26.sp,
    27.sp,
    28.sp,
    29.sp,
    30.sp,
    31.sp,
    32.sp,
    33.sp,
    34.sp,
    35.sp,
    36.sp,
    37.sp,
    38.sp,
    39.sp,
    40.sp,
  ];
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final bool? wrapWords;
  final bool? softWrap;
  final Widget? overFlowReplacement;
  final double? minFontSize;

  const ResponsiveDText({
    Key? key,
    this.text,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textDecoration,
    this.wrapWords,
    this.softWrap,
    this.overFlowReplacement,
    this.minFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      '$text',
      style: GoogleFonts.dosis(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor ?? Theme.of(context).colorScheme.onBackground,
        decoration: textDecoration,
      ),

      softWrap: softWrap ?? true,
      wrapWords: wrapWords ?? true,
      minFontSize: minFontSize ?? 1,
      overflowReplacement: overFlowReplacement,
      //wrapWords: false,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
