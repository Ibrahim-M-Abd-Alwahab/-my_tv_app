import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:sizer/sizer.dart';

class CustomContainerRadious extends StatelessWidget {
  double? width;
  double? height;
  Widget? child;
  Gradient? gradient;
  Color? color;
  double? radius;

  CustomContainerRadious({
    Key? key,
    this.child,
    this.color,
    this.gradient,
    this.height,
    this.radius,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 42.w,
      height: height ?? 5.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 2.w)),
          gradient: gradient),
      child: child ??
          Center(
              child: Text(
            'data',
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          )),
    );
  }
}
