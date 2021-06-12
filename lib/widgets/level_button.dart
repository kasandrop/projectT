import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    Key? key,
    this.text: '',
    this.width: 60.0,
    this.height: 60.0,
    this.borderRadius: 50.0,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      begin: Alignment.topCenter, // new
      end: Alignment.bottomCenter, // new
      // Add one stop for each color.
      // Stops should increase
      // from 0 to 1
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        Colors.green[50]!,
        Colors.green[500]!,
        Colors.green[600]!,
        Colors.green[800]!,
      ],
    );
    return Center(
        child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(24),
        elevation: 5,
        primary: Color.fromARGB(255, 234, 144, 64),
        onPrimary: Color.fromARGB(255, 126, 87, 54),
        shadowColor: Colors.red[300],
        side: BorderSide(
          color: Colors.brown,
          width: 2,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      child: (Text('$text')),
    ));
  }
}
