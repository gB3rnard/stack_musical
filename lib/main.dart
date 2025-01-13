// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_musical/pantallas/screens/favorites_page.dart';
import 'package:stack_musical/pantallas/screens/home_page.dart';
import 'package:stack_musical/pantallas/screens/login_screen.dart';
import 'package:stack_musical/pantallas/screens/starting_page.dart';
import 'package:stack_musical/paquete_favs/favoritos.dart';
import 'package:stack_musical/recursos/estilos_app.dart'; 


void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ListadoFavs.getClaseFavs(),
    child: const MyMusicApp()));
}


class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key}); 


  @override
  Widget build(BuildContext context) {

    
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      //una de las formas mas comunes que tenemos de correr nuestra app
      //en flutter es estableces un a pantalla principal definida en el home
      //Cuando tenemos varias pantallas entre las que tenemos que navegar
      //una forma eficiente de establecer la navegacion es esta: 
      routes: {
        '/startingpage':(context) => const StartigPage(),
        '/loginpage':(context) => const LoginPage(),
        '/homepage':(context) => const HomePage(),
        '/favoritespage':(context) => const FavoritesPage(),
      },
      theme: AppTema(colorSeleccionado: 0).temaPrincipal(),
    );
  }
}


