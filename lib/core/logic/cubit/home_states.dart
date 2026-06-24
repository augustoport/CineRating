part of 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  HomeSuccess(this.movies);

  final List<MovieSimple>? movies;
}

class HomeError extends HomeStates {
  HomeError(this.message);

  final String message;
}
