import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke')),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(joke.setup, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
                  Text(joke.punchline,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
