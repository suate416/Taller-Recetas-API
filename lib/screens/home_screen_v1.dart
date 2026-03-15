import 'package:flutter/material.dart';
import '../models/recetas.dart';
import '../services/recetas_services.dart';
import 'plato_detalles.dart';

class HomeScreenV1 extends StatefulWidget {
  const HomeScreenV1({super.key});

  @override
  State<HomeScreenV1> createState() => _HomeScreenV1State();
}

class _HomeScreenV1State extends State<HomeScreenV1> {
  final RecetasApiService _recetasService = RecetasApiService();
  //Se crea un objeto de la clase RecetasApiService y se guarda en _recetasService
  //usa el objeto para hacer la peticion a la API y obtener las recetas

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
      body: FutureBuilder<List<Recipe>>( //futurebuilder siempre es asincono
        future: _recetasService.fetchRecetas(), //se usa el objeto para llamar a fetchRecetas
        builder: (context, snapshot) { //context es el contextoen el que se esta construyendo la pantalla
          //snapshot es el estado de la peticion, sea bueno o malo
 
          if (snapshot.connectionState == ConnectionState.waiting) { //peticion en proceso
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

          if (snapshot.hasError) { //ERROR
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          //los datos obtenido del snapshot se guardan en recetasData

          if (recetasData.isEmpty) { //si no hay recetas disponibles
            return const Center(child: Text('No hay recetas disponibles'));
          }
          //empieza a construir la pantalla
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: recetasData.length,
            itemBuilder: (context, index) {
              final recetaActual = recetasData[index]; //toma la receta actual de la lista
              return ListTile( //Se crea un ListTile para cada receta
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      recetaActual.image,
                      height: 56,
                      width: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    recetaActual.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recetaActual.cuisine,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recetaActual.rating}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${recetaActual.prepTimeMinutes + recetaActual.cookTimeMinutes} min · ${recetaActual.servings} porciones',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  onTap: () => Navigator.push( 
                    //ir a la pantalla de detalles del plato
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlatilloScreen(receta: recetaActual),
                      //se pasa la receta actual con onTap a la pantalla de detalles
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
