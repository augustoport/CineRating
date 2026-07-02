import 'package:bloc/bloc.dart';

import '../../../../models/crew_model.dart';
import '../../../../models/movie_detail_model.dart';
import '../../../services/movie_service.dart';

part 'movie_states.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitial());
  final MovieService _repo = MovieService();

  void filterCrew(List<CrewModel> crew, MovieDetail movieDetail) {
    final cast = crew.where((c) => c.knownForDepartment == "Acting").toList();
    final director = crew.firstWhere(
      (c) => c.knownForDepartment == "Directing",
      orElse: () => CrewModel(name: "N/A", knownForDepartment: "Directing"),
    );
    emit(MovieSuccess(movieDetail, cast, director));
  }

  Future<void> getMovieDetails(String movieId) async {
    emit(MovieLoading());
    try {
      final movieDetail = await _repo.getMovieDetails(movieId: movieId);
      final crew = await _repo.getMovieCrew(movieId: movieId);
      filterCrew(crew ?? [], movieDetail);
    } catch (e) {
      emit(MovieError());
    }
  }
}
