import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key, required this.mobile, required this.tab});

  final Widget mobile;
  final Widget tab;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 768) {
        return mobile;
      } else {
        return tab;
      }
    });
  }
}
