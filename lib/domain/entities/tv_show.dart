class TvShow {
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final DateTime? firstAirDate;
  final List<int>? genreIds;

  TvShow({
    required this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.firstAirDate,
    this.genreIds,
  });
}
