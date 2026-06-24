import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? photo;
  final String? title;
  final String? description;
  const MovieCard({super.key, this.photo, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
      child: Row(
        children: [
          if (photo != null) Flexible(flex: 1, child: Image.network(photo!)),
          SizedBox(width: 10),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? "N/A"),
                SizedBox(height: 20),
                Text(
                  description ?? "N/A",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
