import 'dart:ui';

import 'package:flutter/material.dart';

class NavigationBlur extends StatelessWidget {
  final Widget options;
  const NavigationBlur({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.grey.withAlpha(60)),
          child: options,
        ),
      ),
    );
  }
}
