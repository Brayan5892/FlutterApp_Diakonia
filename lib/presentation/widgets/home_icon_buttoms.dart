import 'package:flutter/material.dart';

class CatigoryW extends StatelessWidget {
  String image;
  String text;
  Color color;
  String ruta;

  CatigoryW({this.image, this.text, this.color, this.ruta});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 157,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(178, 139, 154, 153),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 120,
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 20),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, ruta);
         
      },
    );
  }
}
