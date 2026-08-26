import 'dart:ui';

import 'package:cinerating/widgets/content_list.dart';
import 'package:cinerating/widgets/navigation_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/home_controller.dart';
import '../core/logic/cubit/home/home_cubit.dart';
import '../shared/themes/app_colors.dart';
import '../widgets/session_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit homeCubit = HomeCubit();
  HomeController homeController = HomeController();

  @override
  initState() {
    Future.microtask(() async {
      homeCubit.getMovies();
    });
    super.initState();
  }

  @override
  dispose() {
    homeController.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 20,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "WikiCine",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      drawer: Drawer(width: media.size.width * 0.7, child: DrawerWidget()),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
                  controller: homeController.searchController,

                  onEditingComplete: () {
                    homeController.setList(
                      homeController.searchController.text,
                      homeCubit,
                    );
                    homeController.searchController.clear();
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

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.backgroundColor),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/img/logo_mini.png",
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    "Olá, Augusto",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text("Profile", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              BlocProvider.of<HomeCubit>(context).getMovies();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text("Settings", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              BlocProvider.of<HomeCubit>(context).getTvShows();
            },
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 30,
            ),
            child: ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text("Exit", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
