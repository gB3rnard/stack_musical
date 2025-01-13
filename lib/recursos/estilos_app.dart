import 'package:flutter/material.dart'; 


const Color colorPrimario = Colors.greenAccent; 

const List<Color> colorTheme = [
  colorPrimario, 
  Colors.redAccent, 
  Colors.deepPurpleAccent, 
  Colors.blueAccent
];


class AppTema {
  final int colorSeleccionado; 

  AppTema({
    this.colorSeleccionado = 0
  })
  :assert (colorSeleccionado >=0 && colorSeleccionado <=3, 
  'El indice de colores debe estar entre 0 y ${colorTheme.length-1}');

  ThemeData temaPrincipal() {
    return ThemeData(
      useMaterial3: true, 
      colorSchemeSeed: colorTheme[colorSeleccionado]
    );
  }
}