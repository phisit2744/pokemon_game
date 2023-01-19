import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_screen.dart';
import 'package:pokedex/pokemon_list_model.dart';
import 'package:pokedex/pokemon_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokemon',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PokemonService pokemonkService = PokemonService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: pokemonkService.getPokemonList(),
          builder: (context, AsyncSnapshot<PokemonListModel> snapshot) {
            if (snapshot.hasData) {
              PokemonListModel lists = snapshot.data!;
              return ListView(
                children: lists.results!
                    .map((PokemonListitem e) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetailScreen(
                                        title: e.name!, url: e.url!)));
                          },
                          title: Text(e.name!),
                        ))
                    .toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
