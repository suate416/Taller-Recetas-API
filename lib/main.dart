import 'package:flutter/material.dart';
import 'screens/home_screen_v1.dart'; //con lista version mas simple facil de entender
import 'screens/home_screen_v2.dart'; //con grids
import 'screens/home_screen_v3.dart'; //Card personalizada version mas compleja
import 'screens/home_screen.dart'; //Con todas las vistas, practica de navegacion entre vistas

void main() { //inicio de la aplicacion
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {//clase que crea la app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas App',
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 185, 74, 0),
        ),
      ),
      home: const HomeScreenV3(),
    );
  }
}
