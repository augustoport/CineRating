class Movie {
  final int? id;
  final int? runtime;
  final String? title;
  final String? name;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final DateTime? releaseDate;
  final List<int>? genreIds;

  Movie({
    this.id,
    this.runtime,
    this.title,
    this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.releaseDate,
    this.genreIds,
  });
}
