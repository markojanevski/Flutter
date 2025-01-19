import 'package:flutter/material.dart';
import 'package:shegi1_app/screens/favorites_screen.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';

class JokesListScreen extends StatefulWidget {
  final String jokeType;

  const JokesListScreen({Key? key, required this.jokeType}) : super(key: key);

  @override
  State<JokesListScreen> createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  final List<Joke> favoriteJokes = [];

  void toggleFavorite(Joke joke) {
    setState(() {
      if (favoriteJokes.contains(joke)) {
        favoriteJokes.remove(joke);
      } else {
        favoriteJokes.add(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jokeType),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(widget.jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFavorite = favoriteJokes.contains(joke);

                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: () => toggleFavorite(joke),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
