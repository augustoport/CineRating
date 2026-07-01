import 'package:bloc/bloc.dart';

import '../../../../models/movie_simple_model.dart';
import '../../../services/movie_service.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  final MovieService _repo = MovieService();

  Future<void> getMovies() async {
    emit(HomeLoading());
    try {
      final movies = await _repo.getMovies();
      emit(HomeSuccess(movies));
    } catch (e) {
      emit(HomeError('Não foi possível carregar os filmes'));
    }
  }

  Future<void> getMovie(String? movie) async {
    emit(HomeLoading());
    try {
      if (movie != null && movie != "") {
        final movies = await _repo.getMovieByName(movie: movie);
        emit(HomeSuccess(movies));
      } else {
        getMovies();
      }
    } catch (e) {
      emit(HomeError("Não foi possivel buscar o filme"));
    }
  }
}
