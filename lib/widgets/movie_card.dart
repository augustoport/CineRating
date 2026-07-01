import 'dart:ffi';

import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? photo;
  final String? title;
  final String? vote;
  const MovieCard({super.key, this.photo, this.title, this.vote});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.black],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
        color: Colors.red,
      ),
      child: Row(
        children: [
          if (photo != null) ...[
            Image.network(photo!, cacheHeight: (size.height * .2).ceil()),
          ] else ...[
            Container(
              height: size.height * .2,
              width: size.width * .23,
              decoration: BoxDecoration(color: Colors.grey.shade400),
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ],

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text(vote ?? "N/A", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
