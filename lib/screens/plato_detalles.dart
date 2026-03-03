import 'package:flutter/material.dart';
import '../models/recetas.dart';

class PlatilloScreen extends StatelessWidget {
  const PlatilloScreen({super.key, required this.receta});
  final Recipe receta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.name),
        backgroundColor: const Color.fromARGB(255, 185, 74, 0),
        centerTitle: true,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              receta.image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
                color: Colors.grey.shade300,
                child: const Icon(Icons.restaurant, size: 64),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receta.cuisine,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${receta.prepTimeMinutes + receta.cookTimeMinutes} min · ${receta.servings} porciones · ${receta.caloriesPerServing} cal',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ingredientes',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...receta.ingredients.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $e'),
                      )),
                  const SizedBox(height: 16),
                  Text(
                    'Instrucciones',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...receta.instructions.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('${e.key + 1}. ${e.value}'),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}