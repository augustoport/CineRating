import 'package:bloc/bloc.dart';

import '../../../../models/movie_detail_model.dart';
import '../../../services/movie_service.dart';

part 'movie_states.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitial());
  final MovieService _repo = MovieService();

  Future<void> getMovieDetails(String movieId) async {
    emit(MovieLoading());
    try {
      final movieDetail = await _repo.getMovieDetails(movieId: movieId);
      emit(MovieSuccess(movieDetail));
    } catch (e) {
      emit(MovieError());
    }
  }
}
