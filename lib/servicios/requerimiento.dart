/* 
import 'package:dio/dio.dart';
import 'package:stack_musical/models/image_post.dart';

String url = "https://pokeapi.co/api/v2/pokemon/ditto";

Future<ImagePosts> obtenerImagen() async {

    final response = await Dio().get(url); 

    return imagePostsFromJson(response.data);
  } */
























/* import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:stack_musical/paquete_favs/galeria_musical.dart';



class RequerimientoHttp {
  
  Future<List<GaleriaImg>?> getImages() async {

    final response = await http.get(Uri.parse('https://www.mixcloud.com/spartacus/party-time/'));

    List<GaleriaImg> portadas =[];
    
    
    if (response.statusCode ==200) {
      //la siguiente conversion permite limpiar la salida de caracteres extraños
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var item in jsonData["pictures"]) {

        
        portadas.add(
          GaleriaImg(item["medium_mobile"], item["medium"])
        ); 

       
      }

    }else {
      throw Exception('Fallo la conexion');
    }

    return portadas;

  }
} */