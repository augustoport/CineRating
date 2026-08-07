import 'package:flutter/material.dart';

import '../shared/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final double padding;
  final Function()? onMenuPressed;

  const CustomAppBar({super.key, required this.padding, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: padding),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.backgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onMenuPressed,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(Icons.menu, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              "CineWiki",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.menu, color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
