import '../models/movie_simple_model.dart';
import '../repository/home_repo.dart';

class HomeController {
  final HomeRepository _api = HomeRepository();
  List<MovieSimple>? movies = [];

  Future<void> getMovies() async {
    movies = await _api.getMovies();
  }
}
