import 'package:flutter/material.dart';

import '../core/logic/cubit/home/home_cubit.dart';

class HomeController {
  final TextEditingController searchController = TextEditingController();

  void setList(String? search, HomeCubit homeCubit) async {
    final state = homeCubit.state;

    if (state is HomeMovie) {
      if (search != null && search != "") {
        homeCubit.getMovie(search);
      } else {
        homeCubit.getMovies();
      }
    } else if (state is HomeTv) {
      if (search != null && search != "") {
        homeCubit.getTvShow(search);
      } else {
        homeCubit.getTvShows();
      }
    }
  }
}
