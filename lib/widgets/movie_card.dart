import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? photo;
  final String? title;
  final String? vote;
  const MovieCard({super.key, this.photo, this.title, this.vote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.deepPurple, Colors.black], begin: AlignmentGeometry.topCenter, end: AlignmentGeometry.bottomCenter),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (photo != null) Expanded(child: Image.network(photo!)),
          Text(
            title ?? "N/A",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber),
              Text(
                vote ?? "N/A",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
