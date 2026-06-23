import 'package:flutter/material.dart';

import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes'), centerTitle: true),
      body: Column(
        children: [
          if ((controller.movies?.length ?? 0) > 0) ...[
            Expanded(
              child: ListView.builder(
                itemCount: controller.movies?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text("controller.movies?[index].title ?? ''"),
                        Text("controller.movies?[index].overview ?? ''"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Column(
                children: [
                  Text("Carregando...", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        controller.getMovies();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.refresh, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Row(
              children: [
                Text(
                  "Powered by: The Movie Database | Augusto Portella",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
