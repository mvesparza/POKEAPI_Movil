import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonController {
  final String apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=500"; // URL de la API

  Future<List<Pokemon>> obtenerPokemones() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data["results"] as List;

        // Mapeamos los resultados a una lista de objetos `Pokemon`
        List<Pokemon> pokemones = results.asMap().entries.map((entry) {
          int id = entry.key + 1; // Generar un ID basado en la posición
          return Pokemon(
            id: id,
            nombre: entry.value["name"],
            urlImagen: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
          );
        }).toList();

        return pokemones;
      } else {
        throw Exception("Error al cargar los Pokémon: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al obtener los Pokémon: $e");
      return [];
    }
  }

  void eliminarPokemon(int id) {
    // Implementación local (opcional)
  }

  void actualizarPokemon(Pokemon pokemonActualizado) {
    // Implementación local (opcional)
  }

  void agregarPokemon(Pokemon nuevoPokemon) {
    // Implementación local (opcional)
  }
}
