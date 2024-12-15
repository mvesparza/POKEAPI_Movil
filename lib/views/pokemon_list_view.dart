import 'package:flutter/material.dart';
import '../controllers/pokemon_controller.dart';
import '../models/pokemon_model.dart';
import 'pokemon_add_view.dart';
import 'pokemon_update_view.dart';
import 'package:flutter/services.dart'; // Importa para SystemNavigator

class PokemonListView extends StatefulWidget {
  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final PokemonController controlador = PokemonController();
  List<Pokemon> pokemones = [];
  List<Pokemon> pokemonesFiltrados = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarPokemones();
    _searchController.addListener(_filtrarPokemones);
  }

  void _cargarPokemones() async {
    final listaPokemones = await controlador.obtenerPokemones();
    setState(() {
      pokemones = listaPokemones;
      pokemonesFiltrados = listaPokemones;
    });
  }

  void _filtrarPokemones() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      pokemonesFiltrados = pokemones
          .where((pokemon) =>
          pokemon.nombre.toLowerCase().contains(query))
          .toList();
    });
  }

  void _eliminarPokemon(int id) {
    setState(() {
      pokemones.removeWhere((pokemon) => pokemon.id == id);
      pokemonesFiltrados = pokemonesFiltrados
          .where((pokemon) => pokemon.id != id)
          .toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pokémon eliminado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POKÉDEX"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Salir de la aplicación
              SystemNavigator.pop(); // O puedes usar Navigator.pop() dependiendo del flujo
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.redAccent,
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Buscar Pokémon...",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: pokemonesFiltrados.isEmpty
                ? const Center(
              child: Text(
                "No hay Pokémon disponibles",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: pokemonesFiltrados.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonesFiltrados[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pokemon.urlImagen,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        pokemon.nombre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () async {
                              final updatedPokemon = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PokemonUpdateView(
                                      pokemon: pokemon),
                                ),
                              );

                              if (updatedPokemon != null) {
                                setState(() {
                                  final index = pokemones.indexWhere(
                                          (p) =>
                                      p.id == updatedPokemon.id);
                                  if (index != -1) {
                                    pokemones[index] = updatedPokemon;
                                    _filtrarPokemones();
                                  }
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () => _eliminarPokemon(pokemon.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoPokemon = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PokemonAddView()),
          );

          if (nuevoPokemon != null) {
            setState(() {
              pokemones.add(nuevoPokemon);
              _filtrarPokemones();
            });
          }
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
