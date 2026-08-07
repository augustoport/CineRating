import 'dart:ui';

import 'package:cinerating/widgets/content_list.dart';
import 'package:cinerating/widgets/navigation_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logic/cubit/home/home_cubit.dart';
import '../shared/themes/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/session_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // } else if (state is HomePeople) {
    //   if (search != null && search != "") {
    //     homeCubit.getPersonByName(search);
    //   } else {
    //     homeCubit.getPeople();
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          padding: media.padding.top + 20,
          onMenuPressed: () {
            if (context.mounted) {
              Scaffold.of(context).openDrawer();
            }
          },
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      drawer: Drawer(
        width: media.size.width * 0.7,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hint: Row(
                      children: [Icon(Icons.search), Text("Pesquisar")],
                    ),
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
              Expanded(
                child: BlocBuilder(
                  bloc: homeCubit,
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeMovie) {
                      return ContentList(
                        onRefresh: () => homeCubit.getMovies(),
                        content: state.movies ?? [],
                        type: 'movie',
                      );
                    }

                    if (state is HomeTv) {
                      return ContentList(
                        onRefresh: () => homeCubit.getTvShows(),
                        content: state.tvShows ?? [],
                        type: 'tv',
                      );
                    }

                    if (state is HomeError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: media.padding.bottom,
            width: media.size.width,
            child: BlocBuilder(
              bloc: homeCubit,
              builder: (context, s) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: NavigationBlur(
                    options: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SessionCard(
                          icon: Icons.movie,
                          session: "Movie",
                          onTap: homeCubit.getMovies,
                          active: s is HomeMovie,
                        ),
                        SessionCard(
                          icon: Icons.tv,
                          session: "TV",
                          onTap: homeCubit.getTvShows,
                          active: s is HomeTv,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
