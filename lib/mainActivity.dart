import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:heatable_poekmon/pokemon.dart';

import 'PokemonStatsScreen.dart';

void main() =>
    runApp(MaterialApp(
      title: "Pokemon heatable",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    )); //MaterialApp

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  late PokeHub pokeHub;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon heatable"),
        backgroundColor: Colors.cyan,
      ), //AppBaar

      body: pokeHub == null
          ? Center(
        child: CircularProgressIndicator(),
      ) //Center
          : GridView.count(
          crossAxisCount: 2,
          children: pokeHub.pokemon!
              .map((poke) =>
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            PokeDetail(
                              pokemon: poke,
                            )));
                  },
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(poke.img!))),
                        ), //Container

                        Text(
                          poke.name!,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )) //Padding
              .toList()), //GridView Count

      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh)), //FloatingActionButton
    ); //Scaffold
  }
}
