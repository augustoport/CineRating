import 'dart:ui';

import 'package:cinerating/widgets/content_list.dart';
import 'package:cinerating/widgets/navigation_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logic/cubit/home/home_cubit.dart';
import '../shared/themes/app_colors.dart';
import '../widgets/movie_card.dart';
import '../widgets/session_card.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppColors appColors = AppColors();
  HomeCubit homeCubit = HomeCubit();
  final TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    Future.microtask(() async {
      homeCubit.getMovies();
    });
    super.initState();
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void setList(String? search) async {
    BlocListener(
      bloc: homeCubit,
      listener: (context, state) {
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
        } else if (state is HomePeople) {
          if (search != null && search != "") {
            homeCubit.getPersonByName(search);
          } else {
            homeCubit.getPeople();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 30,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appColors.primaryColor, appColors.backgroundColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "CineRating",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.menu, color: Colors.transparent),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hint: Row(children: [Icon(Icons.search), Text("Pesquisar")]),
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
              ),
              controller: _searchController,

              onEditingComplete: () {
                setList(_searchController.text);
                _searchController.clear();
              },
            ),
          ),
          BlocBuilder(
            bloc: homeCubit,
            builder: (context, state) {
              if (state is HomeLoading) {
                return Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is HomeMovie) {
                return Expanded(
                  child: ContentList(
                    onRefresh: () => homeCubit.getMovies(),
                    content: state.movies ?? [],
                    type: 'movie',
                  ),
                );
              } else if (state is HomeTv) {
                return Expanded(
                  child: ContentList(
                    onRefresh: () => homeCubit.getTvShows(),
                    content: state.tvShows ?? [],
                    type: 'tv',
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Spacer();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: homeCubit,
        builder: (context, state) {
          return NavigationBlur(
            options: Row(
              mainAxisAlignment: .spaceAround,
              children: [
                SessionCard(
                  icon: Icons.movie,
                  session: "Movie",
                  onTap: homeCubit.getMovies,
                  active: state is HomeMovie,
                ),
                SessionCard(
                  icon: Icons.tv,
                  session: "TV",
                  onTap: homeCubit.getTvShows,
                  active: state is HomeTv,
                ),
                SessionCard(
                  icon: Icons.person,
                  session: "People",
                  onTap: () {},
                  active: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
