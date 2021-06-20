import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    Key? key,
    this.text= '',
    this.width= 60.0,
    this.height= 60.0,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {

    return Center(
        child: ElevatedButton(
      onPressed: onTap,
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
      child: (Text('$text',style: TextStyle(fontWeight: FontWeight.bold),)),
    ));
  }
}
