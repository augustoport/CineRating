import 'package:bloc/bloc.dart';
import 'package:cinerating/core/services/tv_service.dart';

import '../../../../models/movie_simple_model.dart';
import '../../../services/movie_service.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  final MovieService _movieRepo = MovieService();
  final TvService _tvRepo = TvService();

  Future<void> getMovies() async {
    emit(HomeLoading());
    try {
      final movies = await _movieRepo.getMovies();
      emit(HomeMovie(movies));
    } catch (e) {
      emit(HomeError('Não foi possível carregar os filmes'));
    }
  }

  Future<void> getMovie(String? movie) async {
    emit(HomeLoading());
    try {
      if (movie != null && movie != "") {
        final movies = await _movieRepo.getMovieByName(movie: movie);
        emit(HomeMovie(movies));
      } else {
        getMovies();
      }
    } catch (e) {
      emit(HomeError("Não foi possivel buscar o filme"));
    }
  }

  Future<void> getTvShows() async {
    emit(HomeLoading());
    try {
      final tvShows = await _tvRepo.getTvShows();
      emit(HomeTv(tvShows));
    } catch (e) {
      emit(HomeError('Não foi possível carregar os filmes'));
    }
  }

  Future<void> getTvShow(String? show) async {}

  Future<void> getPeople() async {}

  Future<void> getPersonByName(String? name) async {}
}
