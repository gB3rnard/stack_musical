
import 'package:flutter/material.dart';
import 'package:stack_musical/pantallas/screens/home_page.dart';
import 'package:stack_musical/paquete_favs/favoritos.dart';



var f = ListadoFavs.getClaseFavs();

double extensionFav = f.listadoFavoritos?.length.toDouble() ?? 0.0;
final ScrollController controladorScroll = ScrollController(
  initialScrollOffset: 0.0,
  keepScrollOffset: true
);

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {

    //final ScrollController controladorScroll = ScrollController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TUS FAVORITOS', 
        style: TextStyle(
          fontWeight: FontWeight.normal, 
          wordSpacing: 2, 
          letterSpacing: 4, 
          fontSize: 26, 
          color: Color.fromARGB(255, 40, 97, 41)),)),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [ Color.fromARGB(255, 105, 240, 211), Color.fromARGB(255, 47, 133, 76)])
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10), 
                  child: Text(f.listadoFavoritos!.length == 1
                  ? 'Tienes ${f.listadoFavoritos?.length} favorito'
                  : 'Actualmente tienes ${f.listadoFavoritos?.length} favoritos',
                        style: const TextStyle(
                          fontFamily: 'Helvetica', 
                          fontSize: 23, 
                          color:  Color.fromARGB(255, 170, 255, 72)),
                  ),
                ),
              ],
            ),
            const Expanded(
              flex: 1,
              child: _ListaAnimada(),
            )
          ]
        ),
      )
    );
          
  }
}

/* class MiListado extends StatelessWidget {
  const MiListado({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controladorScroll,
      itemCount: f.listadoFavoritos?.length ?? 0,
      itemBuilder: (context, index) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              key: UniqueKey(),
              /* leading: IconButton(
                onPressed: () {
                  f.eliminarFavorito(index);
                  
                },
                icon: const Icon(Icons.delete)
              ), */
              //title: f.listadoFavoritos![index], 
            )
          ],
        );
      },
    );
  }
}  */


class _ListaAnimada extends StatefulWidget {
  const _ListaAnimada({Key? key}) : super(key : key);

  @override
  State<_ListaAnimada> createState() => _ListaAnimadaState();
}

class _ListaAnimadaState extends State<_ListaAnimada> {
  //final postImg = f.listadoFavoritos;
  final GlobalKey<AnimatedListState> _key = GlobalKey();


  /* void _removeItem(int index) {
    _key.currentState!.removeItem(
      index, 
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: postales[index]
        );
      },
      duration: const Duration(milliseconds: 300)
    );
    postImg!.removeAt(index);
    f.eliminarFavorito(index);
  } */
  
  
  
  @override
  Widget build(BuildContext context) {
      return Expanded(
            child: AnimatedList(
              key: _key,
              initialItemCount: f.listadoFavoritos!.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  key: UniqueKey(),
                  sizeFactor: animation,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      width: 1250,
                      height: 420,
                      child: postales[index]
                    ),
                  ),
                );
              },
            )
          );
  }
}

/* 
PageView.builder(
            itemCount: f.listadoFavoritos!.length,
            itemBuilder: (context, index) {
              return postales[index];
            },
            scrollDirection: Axis.horizontal,
            controller: PageController(
              viewportFraction: 1
            ),
          )
 */