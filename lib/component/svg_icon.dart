import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  SvgIcon({
    required this.assetImage,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  String assetImage;
  double? height;
  double? width;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetImage,
      height: height,
      width: width,
      color: color,
    );
  }
}
