import 'package:bloc/bloc.dart';
import '../../../models/movie_simple_model.dart';
import '../../services/movie_service.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  final MovieService _homeRepository = MovieService();

  Future<void> getMovies() async {
    emit(HomeLoading());
    try {
      final movies = await _homeRepository.getMovies();
      emit(HomeSuccess(movies));
    } catch (e) {
      emit(HomeError('Não foi possível carregar os filmes'));
    }
  }
}
