import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logic/cubit/home_cubit.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit homeCubit = HomeCubit();
  TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    Future.microtask(() async {
      homeCubit.getMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Colors.black),
      appBar: AppBar(title: const Text('Filmes'), centerTitle: true),
      body: Column(
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
                  children: [
                    Icon(Icons.search),
                    Text("Pesquisar")
                  ],
                ),
                contentPadding: EdgeInsets.only(left: 15),
                border: InputBorder.none,
              ),
              controller: _searchController,
            ),
          ),
          BlocBuilder(
            bloc: homeCubit,
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => homeCubit.getMovies(),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: state.movies?.length ?? 0,
                      itemBuilder: (context, index) {
                        final movie = state.movies![index];
                        return MovieCard(
                          photo: movie.posterPath,
                          title: movie.title,
                          vote: movie.voteAverage.toString(),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is HomeLoading) {
                return Expanded(
                  child: const Center(child: CircularProgressIndicator()),
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

          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.black], begin: AlignmentGeometry.topCenter, end: AlignmentGeometry.bottomCenter)),
            child: Row(
              children: [
                Text(
                  "Powered by: The Movie Database | Augusto Portella",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
