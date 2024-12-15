import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class PokemonAddView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Pokémon"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título principal con estilo
              const Text(
                "Ingresa los datos del nuevo Pokémon",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Campo de texto para el nombre
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nombre del Pokémon",
                  labelStyle: const TextStyle(color: Colors.greenAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Campo de texto para la URL de la imagen
              TextField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: "URL de la imagen",
                  labelStyle: const TextStyle(color: Colors.greenAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.greenAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),

              // Botón para agregar el Pokémon
              ElevatedButton(
                onPressed: () {
                  // Crear nuevo Pokémon
                  final nuevoPokemon = Pokemon(
                    id: DateTime.now().millisecondsSinceEpoch, // ID único basado en el tiempo
                    nombre: _nameController.text,
                    urlImagen: _imageController.text,
                  );

                  // Regresar el Pokémon a la vista principal
                  Navigator.pop(context, nuevoPokemon);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Cambié "primary" por "backgroundColor"
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text("Agregar Pokémon"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
