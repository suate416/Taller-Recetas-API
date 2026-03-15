import 'package:http/http.dart' as http; //dart pub add http
import '../models/recetas.dart';

//se encarga de hacer la peticion a la API y obtener las recetas
//Incluso se puede reciclar para otras Apps, bastaria con cambiar la URL de la API y modelo

class RecetasApiService {
  final String _baseURL = 'https://dummyjson.com/recipes';

  Future<List<Recipe>> fetchRecetas() async {
    final response = await http.get(Uri.parse(_baseURL));

    if (response.statusCode == 200) {
      final recetas = recetasFromJson(response.body);
      return recetas.recipes;
    } else {
      throw Exception('Error al cargar recetas: ${response.statusCode}');
    }
  }
}

