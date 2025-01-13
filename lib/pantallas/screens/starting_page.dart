import 'package:flutter/material.dart'; 
import 'package:animated_text_kit/animated_text_kit.dart';

class StartigPage extends StatefulWidget {
  const StartigPage({super.key});

  @override
  State<StartigPage> createState() => _StartigPageState();
}

class _StartigPageState extends State<StartigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText('STACK__MUSICAL',
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromARGB(255, 13, 92, 54))),
                FlickerAnimatedText('          _____♫',
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromARGB(255, 13, 92, 54)))
            ]
          ),
        )
      ),
    );
  }
}