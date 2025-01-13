
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';
import 'package:stack_musical/models/image_post.dart';
import 'package:stack_musical/pantallas/presentacion/elementos_formulario.dart';
import 'package:stack_musical/pantallas/screens/login_screen.dart';
import 'package:stack_musical/paquete_favs/favoritos.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:google_fonts/google_fonts.dart';

//Creo un variable para poder almacenar la instancia unica de la clase del ListadoFavoritos
var f = ListadoFavs.getClaseFavs(); 
final List<Widget> imagenes = [];
final List<Widget> postales = []; 

String usuario = '';

PageController controlPagina = PageController(
      viewportFraction: 1, 
);
 
class HomePage extends StatefulWidget { 

  const HomePage 
  
  ({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); 

  const HomePage._(); 

  static HomePage? _claseHome; 

  HomePage getClaseHome() {
    return _claseHome ??= const HomePage._();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  IconData? iconFavs = Icons.favorite_border;
  ImagePost? artista;
  String? nombre;
  Widget? imagenUrl;
  Widget? postal;



  @override
  void initState() {
    super.initState();
    obtenerImagenes();
    obtenerPostales();
    controlPagina.addListener(() {
      if (mounted) {
        setState(() {
        _obtenerIconoFav();
      });
      } 
    });
  }

  @override
  void dispose() {
    controlPagina.removeListener(() {
        _obtenerIconoFav();
     });
    super.dispose();
  }

  List<Widget> obtenerPostales() {
    return postales;
  }


  void _obtenerIconoFav() {
    if (postales.isNotEmpty && controlPagina.page != null) {
      int currentPage = controlPagina.page!.round();
      if (currentPage >= 0 && currentPage < postales.length) {
        if (f.listadoFavoritos!.contains(postales[currentPage])) {
          iconFavs = Icons.favorite;
        } else {
          iconFavs = Icons.favorite_border;
        }
      }
    }
  }

  Future<void> obtenerImagenes() async { // Inicializar id en 1
    for (int index = 1; index <= 150; index++) {
      try{
         final enlaceUri = Uri.parse('https://api.deezer.com/artist/$index');
       final response = await Dio().get(enlaceUri.toString());
        artista = ImagePost.fromJson(response.data);
        if (mounted) {
          setState(() {
          imagenes.add(CreaImg(imageUrl: artista!.pictureMedium ?? '', name: artista!.name ?? '', link: artista!.link ?? '',));
          postales.add(PostalImg(imageUrl: artista!.pictureMedium?? '', name: artista!.name ?? ''));
        });
        }
      }catch (e) {
      setState(() {
        // Mostrar un mensaje de error en el área de la imagen
        imagenes.add(_crearMensajeError());
      });
      e;
    }
  }
  } 

    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Row(
          children: [
            /* const SizedBox(width: 100), 
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favoritespage');
              }, 
              icon: const Icon(Icons.favorite, semanticLabel: 'favoritos', color: Color.fromARGB(255, 165, 49, 64),),
            ), */
            /* const SizedBox(width: 110,), 
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage(),)
                );
                  textControllerNombre.text = "";
                  f.listadoFavoritos?.clear();
              }, 
              icon: const Icon(Icons.logout, color: Color.fromARGB(255, 40, 97, 41),)
            ) */
          ],
        ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          surfaceTintColor: const Color.fromARGB(255, 163, 230, 88),
            child: Container(
              color: Colors.transparent, 
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Center(
                      child: Text('M E N U',
                      style: TextStyle(
                        fontSize: 25, 
                        fontFamily: 'Helvetica', 
                        color: Color.fromARGB(235, 133, 226, 26)
                      ),
                    ),
                    )
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, 
                                        color: Color.fromARGB(255, 40, 97, 41)),
                    title: const Text('Favoritos',
                                style: TextStyle(fontSize: 18, 
                                fontFamily: 'Helvetica', 
                                wordSpacing: 3, 
                                letterSpacing: 4,
                                color: Color.fromARGB(255, 167, 255, 66)
                                ),
                          ),
                    onTap: () {
                      Navigator.pushNamed(context, '/favoritespage');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, 
                                        color: Color.fromARGB(255, 40, 97, 41),),
                    title: const Text('Salir',
                                style: TextStyle(fontSize: 18, 
                                fontFamily: 'Helvetica', 
                                wordSpacing: 3, 
                                letterSpacing: 4,
                                color: Color.fromARGB(255, 167, 255, 66)
                              ),
                          ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage(),)
                  );
                    textControllerNombre.text = "";
                    f.listadoFavoritos?.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Fila de saludo al usuario
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hola :', 
                          style: TextStyle(
                          fontSize: 30, 
                          fontFamily: 'Helvetica', 
                          fontWeight: FontWeight.normal, 
                          wordSpacing: 1, 
                          letterSpacing: 4, 
                          color: Color.fromARGB(255, 40, 97, 41)),
                      ),

                      const SizedBox(width: 20,),

                      // ignore: unnecessary_string_interpolations
                      Text('$usuario', 
                          style: const TextStyle(
                          fontSize: 30, 
                          fontFamily: 'Helvetica', 
                          fontWeight: FontWeight.normal, 
                          wordSpacing: 1, 
                          letterSpacing: 4, 
                          color: Color.fromARGB(255, 18, 235, 170)),
                      ),
                ],
            ),
            //Fila de tarjeta de artista
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    int pagAnt = (controlPagina.page! -1).round();
                    controlPagina.animateToPage(pagAnt, duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
                  },
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 188, 255, 223),
                      gradient: const LinearGradient(
                                        colors: [Color.fromARGB(255, 190, 247, 222), Color.fromARGB(255, 88, 221, 221)],
                                        tileMode: TileMode.decal
                                      )
                    ),
                    child: Center(
                      child: artista != null 
                        ? const GaleriaMusica() 
                        : const CircularProgressIndicator(),
                      ),
                  ),
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {
                    int pagPost = (controlPagina.page! +1).round(); 
                    controlPagina.animateToPage(pagPost, duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
                  },
                ),
              ],
            ),
            //const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final currentPage = controlPagina.page?.round() ?? 0;
                      if (currentPage >= 0 && currentPage < imagenes.length) {
                        imagenUrl = imagenes[currentPage];
                        postal = postales[currentPage];
                      }
                      if (mounted) {
                        setState(() {
                          f.agregarFavoritos(postal!);
                          _obtenerIconoFav();
                        });
                      }
                    },
                    icon: Icon(iconFavs, color: const Color.fromARGB(255, 165, 49, 64),),
                    label: const Text('Añadir a favoritos'),
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }


}



 class GaleriaMusica extends StatelessWidget {

  const GaleriaMusica({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    
    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: controlPagina,
        scrollDirection: Axis.horizontal,
        itemCount: imagenes.length, // Número total de artistas
        itemBuilder: (context, index) {
          return imagenes[index];
        },
      ),
    );
  }
}

//Con el siguiente metodo voy a obtener la imagen segun el id Del artista obtenido: 

 
class CreaImg extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String link;

  const CreaImg({
    Key? key, 
    required this.imageUrl,
    required this.name,
    required this.link,
  }) : super(key: key); 

  @override
  State<CreaImg> createState() => _CreaImgState();
}

class _CreaImgState extends State<CreaImg> {
  bool _focused = false;
  bool _hovering = false;
  bool _on = false; 

  // Tamaño normal del botón
  final double _normalSizeX = 108.0;
  final double _normalSizeY = 38.0;

  // Tamaño del botón cuando está enfocado o el cursor está encima
  final double _focusedSizeX = 128.0;
  final double _focusedSizeY = 45.0;
  final double _elev = 3;

  // Función para aumentar el tamaño del botón
  double _increaseSize(double currentSize) {
    return currentSize + 3.0;
  }

  // Función para disminuir el tamaño del botón
  double _decreaseSize(double currentSize) {
    return currentSize;
  }

  late final Map<Type, Action<Intent>> _actionMap; 
  final Map<ShortcutActivator, Intent> _shortcutMap = const <ShortcutActivator, Intent> {
    SingleActivator(LogicalKeyboardKey.keyX) :
    ActivateIntent(),
  }; 

  double _elevated(double currentElev) {
    return currentElev = _elev;
  }

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<Intent>(
        onInvoke: (Intent intent) =>_toggleState(),
      )
    };
  } 

  void _toggleState() {
    setState(() {
      _on = !_on;
    });
  }

  void _handleFocusHighlight(bool value) {
    setState(() {
      _focused = value;
    });
  }

  void _handleHoveHighlight(bool value) {
    setState(() {
      _hovering = value;
    });
  } 

  

  Color get color {
    Color baseColor = const Color.fromARGB(255, 221, 255, 182);
    if (_focused) {
      baseColor = Color.alphaBlend(const Color.fromARGB(255, 56, 252, 193).withOpacity(0.5), baseColor);
    }
    if (_hovering) {
      baseColor = Color.alphaBlend(const Color.fromARGB(255, 74, 255, 225).withOpacity(0.2), baseColor);
    }
    return baseColor;
  } 


  Icon get iconBtn {
    Icon iconBtn = const Icon(Icons.remove_red_eye_outlined, color: Color.fromARGB(255, 165, 49, 64),);
    if (_focused) {
      iconBtn = const Icon(Icons.remove_red_eye, color: Color.fromARGB(255, 165, 49, 64),);
    }
    if (_hovering) {
      iconBtn = const Icon(Icons.remove_red_eye_outlined, color: Color.fromARGB(255, 165, 49, 64),);
    }
    return iconBtn;
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      //color: Colors.transparent,
      surfaceTintColor: const Color.fromARGB(255, 93, 228, 127), 
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 240),
      elevation: 4,
      child: Center(
        child: Column(
          children: [
            Text(widget.name, 
              style: const TextStyle(
                fontSize: 20, 
                fontFamily: 'Helvetica', 
                fontWeight: FontWeight.normal, 
                wordSpacing: 2, 
                letterSpacing: 3, 
                color: Color.fromARGB(255, 40, 97, 41),
              ),
            ),
            Image.network(
              widget.imageUrl,
              width: double.maxFinite,
              height: 320,
            ),
            const SizedBox(height: 4.0,),
            GestureDetector(
              onTap: _toggleState,
              child: FocusableActionDetector(
                onShowFocusHighlight: _handleFocusHighlight,
                onShowHoverHighlight: _handleHoveHighlight,
                actions: _actionMap,
                shortcuts: _shortcutMap,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(_focused || _hovering 
                                                              ? color 
                                                              : const Color.fromARGB(232, 228, 238, 233)),
                    elevation: WidgetStatePropertyAll(_focused || _hovering
                                                              ? _elevated(_elev)
                                                              : 0),
                    maximumSize: WidgetStateProperty.all(_focused || _hovering 
                                                          ? Size(_increaseSize(_focusedSizeX), _increaseSize(_focusedSizeY)) 
                                                          : Size(_normalSizeX, _normalSizeY),
                  ),
                  minimumSize: WidgetStateProperty.all(_focused || _hovering 
                                                         ? Size(_decreaseSize(_focusedSizeX), _decreaseSize(_focusedSizeY)) 
                                                         : Size(_normalSizeX, _normalSizeY),
                  ),
                  animationDuration: const Duration(milliseconds: 20)
                  ),
                  
                  //TODO: Manejar excepcion al intentar abrir enlace
                  
                  onPressed: () async{
                    // Acción al hacer clic en la imagen
                    String linkUri = widget.link;
                    Uri link2 = Uri.parse(linkUri);
                    if (await canLaunchUrl(link2)) {
                      await launchUrl(link2);
                    } else {
                      const Text('no se puede abrir el enlace');
                    }
                  },
                  
                  icon: _focused || _hovering
                       ? iconBtn 
                       : const Icon(Icons.remove_red_eye_outlined, color: Color.fromARGB(255, 165, 49, 64),),
                  label: const Text('Perfil'),),
              ),
            )
          ],
        ),
      ),
    );
  }
} 



Widget _crearMensajeError() {
        return const Center(
          child: Text(
            "OOPS..No hay artistas por aquí :(",
            style: TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold,),
          ),
        );
}




class PostalImg extends StatelessWidget {
  final String imageUrl;
  final String name;
  //final String link;

  const PostalImg({
    Key? key, 
    required this.imageUrl,
    required this.name,
    //required this.link,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    try {
      return Card(
      borderOnForeground: false,
      //color: Colors.transparent,
      surfaceTintColor: const Color.fromARGB(255, 93, 228, 127), 
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 240),
      elevation: 4,
      child: Center(
        child: Column(
          children: [
            Text(name, 
              style: const TextStyle(
                fontSize: 20, 
                fontFamily: 'Helvetica', 
                fontWeight: FontWeight.normal, 
                wordSpacing: 2, 
                letterSpacing: 3, 
                color: Color.fromARGB(255, 40, 97, 41),
              ),
            ),
            Image.network(
              imageUrl,
              width: double.maxFinite,
              height: 320,
            ),
            const SizedBox(height: 4.0,),
          ],
        ),
      ),
    );
    } catch (e) {
      return _crearMensajeError();
    }
  }
}









