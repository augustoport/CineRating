part of 'movie_cubit.dart';

abstract class MovieStates {}

class MovieInitial extends MovieStates {}

class MovieLoading extends MovieStates {}

class MovieSuccess extends MovieStates {
  final MovieDetail movieDetail;
  final List<CrewModel> cast;
  final CrewModel director;

  MovieSuccess(this.movieDetail, this.cast, this.director);
}

class MovieError extends MovieStates {
  final String message;
  MovieError({this.message = "Não foi possível carregar os detalhes do filme"});
}
