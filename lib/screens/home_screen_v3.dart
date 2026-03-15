import 'package:flutter/material.dart';
import '../models/recetas.dart';
import '../services/recetas_services.dart';
import '../widgets/card_recetas_personalizada.dart';

class HomeScreenV3 extends StatefulWidget {
  const HomeScreenV3({super.key});

  @override
  State<HomeScreenV3> createState() => _HomeScreenV3State();
}

class _HomeScreenV3State extends State<HomeScreenV3> {
  final RecetasApiService _recetasService = RecetasApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Libro de Recetas',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 185, 74, 0),

        //backgroundColor: const Color.fromARGB(255, 111, 0, 185),
        centerTitle: true,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recetasService.fetchRecetas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando recetas...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar las recetas',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => setState(() {}),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final recetasData = snapshot.data ?? [];

          if (recetasData.isEmpty) {
            return const Center(child: Text('No hay recetas disponibles'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: recetasData.length,
            itemBuilder: (context, index) {
              final recetaActual = recetasData[index];
              return CardRecetasPersonalizada(recipe: recetaActual);
            },
          );
        },
      ),
    );
  }
}