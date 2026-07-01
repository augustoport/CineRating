part of 'movie_cubit.dart';

abstract class MovieStates {}

class MovieInitial extends MovieStates {}

class MovieLoading extends MovieStates {}

class MovieSuccess extends MovieStates {
  final MovieDetail movieDetail;

  MovieSuccess(this.movieDetail);
}

class MovieError extends MovieStates {
  final String message;
  MovieError({this.message = "Não foi possível carregar os detalhes do filme"});
}
