
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stack_musical/pantallas/presentacion/elementos_formulario.dart';
import 'package:stack_musical/pantallas/screens/home_page.dart';
//import 'package:stack_musical/recursos/estilos_app.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


//var home = const HomePage().getClaseHome(); 

class LoginPage extends StatefulWidget {

  const LoginPage
  
({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  const LoginPage._();

  static LoginPage? _claseLogin;

  LoginPage getClaseLogin() {
    return _claseLogin ??= const LoginPage._();
  }

}

class _LoginPageState extends State<LoginPage> {

  @override
  
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}


class LoginScreen extends StatefulWidget { 

 const LoginScreen
({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  double alturaBox = 450;
  double anchoBox = 400;
  double h1 = 40; 
  double letra = 16;
  double altCaja1 = 50; 
  double altCaja2 = 65; 
  double altCaja3 = 80;
  double altCaja4 = 30;
  double altCaja5 = 30;   



  void _expandBox() {
    setState(() {
      alturaBox = 600; 
      anchoBox = 600;
      h1 = 65;
      letra = 20;
      altCaja1 = 80;
      altCaja2 = 90; 
      altCaja3 = 85; 
      altCaja4 = 35; 
      altCaja5 = 55;
    });
  }

  

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        //El appBar va a contener unicamente una imagen como propiedad de fondo
        /* appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: colorTheme[0],
          //title: const Center(child: Image(image: AssetImage('assets/box2.jpg'))),
        ), */
        //El body de este scaffold va a ser una columna que contiene
        //a varios widgets de texto y textfields
        body: Stack(
          children: [
            Expanded(
              child: Center(/* child: Image(image: AssetImage()) */)),
            Center(
            child: GestureDetector(
              onTap: _expandBox,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1900),
                height: alturaBox,
                width: anchoBox,
                
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 9, 126, 102),
                    width: 0.5, 
                    style: BorderStyle.solid
                  )
                ),
                //color: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: altCaja1,
                        width: 530,
                        child: Titulo(
                          texto: '', 
                          tamanyo: h1, 
                          colorTexto: Color.fromARGB(255, 24, 131, 95), 
                          fuente: 'Helvetica',
                          weight: FontWeight.bold,),
                      ),
                      /* const SizedBox(
                        height: 65,
                        width: 380,
                        child: Titulo(
                          texto: 'STACK__MUSICAL', 
                          tamanyo: 40, 
                          colorTexto: Color.fromARGB(255, 163, 230, 88), 
                          fuente: 'Helvetica',
                          weight: FontWeight.bold,),
                      ), */
                      SizedBox(
                        height: altCaja2,
                        width: 580,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 40, 
                            color: Color.fromARGB(235, 133, 226, 26), 
                            shadows: [
                              Shadow(
                              blurRadius: 7.0, 
                              color: Color.fromARGB(255, 60, 245, 100), 
                              offset: Offset(0, 0),
                            )
                            ]
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText('STACK__MUSICAL',
                                                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: h1)),
                              FlickerAnimatedText('          _____♫',
                                                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: h1))
                            ]),
                        ),
                      ),
                      SizedBox(
                        height: altCaja3,
                        width: 360,
                        child: Titulo(
                          texto: 'Guarda a tus artistas favoritos', 
                          tamanyo: letra, 
                          colorTexto: Color.fromARGB(255, 40, 97, 41), 
                          fuente: 'Helvetica', 
                          weight: FontWeight.normal,),
                      ),
                      SizedBox(
                        height: altCaja4,
                        width: 360,
                        child: CampoDeTexto(pistaTexto: 'Introduce nombre',),
                      ),
                      SizedBox(height: 35,),
                      
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: SizedBox(
                            height: altCaja5,
                            width: 230,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                elevation: WidgetStatePropertyAll(3),
                              ),
                            onPressed: (){
                              if (textControllerNombre.text =="" 
                              || textControllerNombre.text.contains(RegExp(r'[^a-zA-Z0-9]'))) {
                                showDialog (
                                  context: context,
                                  builder: (context) =>AlertDialog(
                                  title: const Text('Debes introducir un nombre \nde usuario sin caracteres.'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, 
                                    child: const Center(child: Text('Ok')))
                                  ],
                                ));
                              }else{
                                
                                usuario = textControllerNombre.text;
                                String pl = usuario[0].toUpperCase();
                                String resto = usuario.substring(1).toLowerCase();
                                usuario = pl+resto;
                                  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const HomePage(),)
                                );
                                
                              }
                              
                            }, 
                            icon: const Icon(Icons.music_video), 
                            label: Text('Comenzar', style: TextStyle(fontSize: 16),)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ]
        ),
      ),
    );
  }
}












