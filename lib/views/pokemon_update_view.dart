import 'package:flutter/material.dart';
import '../controllers/pokemon_controller.dart';
import '../models/pokemon_model.dart';

class PokemonUpdateView extends StatelessWidget {
  final Pokemon pokemon;
  final TextEditingController _nameController;
  final TextEditingController _imageController;
  final PokemonController controlador = PokemonController();

  PokemonUpdateView({required this.pokemon})
      : _nameController = TextEditingController(text: pokemon.nombre),
        _imageController = TextEditingController(text: pokemon.urlImagen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Pokémon"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title with style
              const Text(
                "Actualiza los datos del Pokémon",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Name input field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nombre del Pokémon",
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Image URL input field
              TextField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: "URL de la imagen",
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),

              // Update button
              ElevatedButton(
                onPressed: () {
                  // Create the updated Pokémon
                  final pokemonActualizado = Pokemon(
                    id: pokemon.id,
                    nombre: _nameController.text,
                    urlImagen: _imageController.text,
                  );

                  // Update the Pokémon
                  controlador.actualizarPokemon(pokemonActualizado);

                  // Return the updated Pokémon to the previous screen
                  Navigator.pop(context, pokemonActualizado);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("Actualizar Pokémon"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
