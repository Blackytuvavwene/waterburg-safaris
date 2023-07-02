import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppSpacing {
  // height spacing
  static double smallY = 2.h;
  static double mediumY = 4.h;
  static double largeY = 6.h;
  static double xLargeY = 8.h;

  // width spacing
  static double smallX = 2.w;
  static double mediumX = 3.w;
  static double largeX = 4.w;
  static double xLargeX = 5.w;
}

class SizedBoxAppSpacing {
  // height spacing
  static Widget smallY() => SizedBox(
        height: AppSpacing.smallY,
      );
  static Widget mediumY() => SizedBox(
        height: AppSpacing.mediumY,
      );
  static Widget largeY() => SizedBox(
        height: AppSpacing.largeY,
      );
  static Widget YLargeY() => SizedBox(
        height: AppSpacing.xLargeY,
      );

  // width spacing
  static Widget smallX() => SizedBox(
        height: AppSpacing.smallX,
      );
  static Widget mediumX() => SizedBox(
        height: AppSpacing.mediumX,
      );
  static Widget largeX() => SizedBox(
        height: AppSpacing.largeX,
      );
  static Widget xLargeX() => SizedBox(
        height: AppSpacing.xLargeX,
      );
}


// love class
