import 'package:flutter/material.dart';
import '../models/recetas.dart';
import '../services/recetas_services.dart';
import 'plato_detalles.dart';

/// V1: Solo vista en Grid
class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
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
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: recetasData.length,
            itemBuilder: (context, index) {
              final recetaActual = recetasData[index];
              return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 4,
                  shadowColor: const Color.fromARGB(255, 185, 74, 0),

                  // color: const Color.fromARGB(255, 254, 168, 110),
                  child: InkWell(
                    //ir a la pantalla de detalles del plato
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlatilloScreen(receta: recetaActual),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            recetaActual.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recetaActual.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber.shade700,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${recetaActual.rating}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                    const Spacer(),
                                    Text(
                                      recetaActual.cuisine,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}