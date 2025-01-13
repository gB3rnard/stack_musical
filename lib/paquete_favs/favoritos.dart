import 'package:flutter/material.dart';



class ListadoFavs extends ChangeNotifier{

  List<Widget>? listadoFavoritos = [];
  

  //creo una variable estatica para almacenar la unica instancia de la clase
  static ListadoFavs? _claseFavs; 

  //constructor privado para evitar que la clase se 
  //instancie desde fuera 
  ListadoFavs._() {
    listadoFavoritos = [];
  }

  //metodo estatico para obtener la instancia unica de la clase: 
  static ListadoFavs getClaseFavs() {
    
    return _claseFavs ??= ListadoFavs._();

  }

   @override
  void notifyListeners() {
    super.notifyListeners();
  }

  bool esFavorito(Widget img) {
    return listadoFavoritos!.contains(img);
  } 

  void agregarFavoritos(Widget img) {
    if (!esFavorito(img)) {
    listadoFavoritos!.add(img);
    } else {
    listadoFavoritos!.remove(img);
    }

    notifyListeners();
  }

  void eliminarFavorito(int index) {
    listadoFavoritos?.removeAt(index);
    notifyListeners();
  }


}


