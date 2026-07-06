import 'package:cinerating/models/movie_simple_model.dart';
import 'package:cinerating/views/tv_show_detail_page.dart';
import 'package:flutter/material.dart';

import '../views/movie_detail_page.dart';
import 'movie_card.dart';

class ContentList extends StatelessWidget {
  final RefreshCallback onRefresh;
  final List<MovieSimple> content;
  final String type;
  const ContentList({
    super.key,
    required this.onRefresh,
    required this.content,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.size.width * .5,
                childAspectRatio: 1.5,
                mainAxisSpacing: 15,
              ),
              itemCount: content.length,
              itemBuilder: (context, index) {
                final show = content[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => type == "movie"
                          ? MovieDetailPage(movieId: (show.id ?? 0).toString())
                          : TvShowDetailPage(id: (show.id ?? 0).toString()),
                    ),
                  ),
                  child: MovieCard(
                    photo: show.posterPath,
                    title: show.title ?? show.name,
                    vote: (show.voteAverage ?? 0).toStringAsFixed(1),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: size.padding.bottom + 35),
        ],
      ),
    );
  }
}
