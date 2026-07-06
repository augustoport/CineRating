import 'package:bloc/bloc.dart';
import 'package:cinerating/core/services/tv_service.dart';
import 'package:cinerating/models/tv_show_model.dart';

import '../../../../models/tv_crew_model.dart';

part 'serie_state.dart';

class SerieCubit extends Cubit<SerieState> {
  SerieCubit() : super(SerieInitial());
  final TvService _repo = TvService();

  Future<void> getSerieDetail(String serieId) async {
    emit(SerieLoading());
    try {
      final serie = await _repo.getShowId(serieId: serieId);
      final cast = await _repo.getShowCrew(id: serieId);
      emit(SerieSuccess(serie, cast?.cast ?? []));
    } catch (e) {
      emit(SerieError());
    }
    return;
  }
}
