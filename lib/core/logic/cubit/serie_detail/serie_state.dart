part of 'serie_cubit.dart';

abstract class SerieState {}

class SerieInitial extends SerieState {}

class SerieLoading extends SerieState {}

class SerieSuccess extends SerieState {
  SerieSuccess(this.tvShow);

  TvShowModel tvShow;
}

class SerieError extends SerieState {}
