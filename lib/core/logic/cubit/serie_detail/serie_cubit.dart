import 'package:bloc/bloc.dart';
import 'package:cinerating/core/services/tv_service.dart';
import 'package:cinerating/models/tv_show_model.dart';

part 'serie_state.dart';

class SerieCubit extends Cubit<SerieState> {
  SerieCubit() : super(SerieInitial());
  final TvService _repo = TvService();

  Future<void> getSerieDetail(String serieId) async {
    emit(SerieLoading());
    try {
      final serie = await _repo.getShowId(serieId: serieId);
      emit(SerieSuccess(serie));
    } catch (e) {
      emit(SerieError());
    }
  }
}
