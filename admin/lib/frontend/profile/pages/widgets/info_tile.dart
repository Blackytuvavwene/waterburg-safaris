// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class InfoTile extends HookConsumerWidget {
  const InfoTile({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.titleFontWeight,
    this.subtitleFontWeight,
    this.titleFontSize,
    this.subtitleFontSize,
  });
  final String? title;
  final String? subtitle;
  final Icon? icon;
  final FontWeight? titleFontWeight;
  final FontWeight? subtitleFontWeight;
  final double? titleFontSize;
  final double? subtitleFontSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DText(
            text: title ?? '',
            fontWeight: titleFontWeight ?? FontWeight.w700,
            fontSize: titleFontSize ?? 16.sp,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          DText(
            text: subtitle ?? '',
            fontWeight: subtitleFontWeight ?? FontWeight.w400,
            fontSize: subtitleFontSize ?? 12.sp,
          ),
        ],
      ),
    );
  }
}
