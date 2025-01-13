// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

final textControllerNombre = TextEditingController();



class Titulo extends StatelessWidget {

  final String texto;
  final double tamanyo; 
  final Color colorTexto;
  final String fuente;
  final FontWeight weight;

  const Titulo({super.key, 
  required this.texto, 
  required this.tamanyo, 
  required this.colorTexto, 
  required this.fuente, 
  required this.weight});

  

  @override
  Widget build(BuildContext context) {
    return Text(
      texto, style: TextStyle(color: colorTexto, fontSize: tamanyo, fontFamily: fuente, fontWeight: weight),
    );
  }
}


//El widget TextField, decido personalizarlo y de forma independiente 
//agregar diferentes propiedades
//De esta forma puedo llamar a este widget estatico varias veces
//sin repetirme a mi misma (DRY) dentro del bloque de codigo 
//de la clase que se construye

class CampoDeTexto extends StatefulWidget {

  final String pistaTexto;
  
  

  const CampoDeTexto({
    super.key, 
    required this.pistaTexto,
  });

  @override
  State<CampoDeTexto> createState() => _CampoDeTextoState();
}

class _CampoDeTextoState extends State<CampoDeTexto> {

  @override
  Widget build(BuildContext context) {

    

    final focusNode = FocusNode();
    


    return TextField(
      keyboardType: TextInputType.name,
      maxLength: 80,
      controller: textControllerNombre,
      decoration: InputDecoration(
        hintText: widget.pistaTexto,
      ),
      autofocus: true,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
    );



  }

  
}