import 'package:flutter/material.dart';

class MyColors {
  //main bg color
  static Color whiteShade3 = const Color.fromRGBO(241, 246, 255, 1);

  //for buttons and exposed texts mostly
  static Color royalBlue = const Color(0xFF306BDD);

  //inactive nav bar
  static Color poloBlue = const Color(0xFF88a1c8);

  //for stand alone buttons
  static Color white = const Color.fromARGB(255, 253, 253, 253);

  //navigation bar
  static Color navBar = whiteShade3;

  //for rating
  static Color emptyRate = const Color(0xFF808080);
  static Color fullRate = Colors.yellow.shade700;

  //highlighted text when on royalBlue bg (used for price mostly)
  static Color black = const Color.fromARGB(255, 0, 0, 0);

  //main logo gradient
  static List<Color> logoGradient = [
    const Color.fromARGB(255, 68, 48, 221),
    const Color(0xFF306BDD),
    const Color.fromARGB(255, 48, 140, 221),
    const Color.fromARGB(255, 48, 178, 221),
  ];

  static List<Color> weddingCardGradient = const [
    Color(0xFFff758c),
    Color.fromARGB(255, 255, 65, 112),
    Color.fromARGB(255, 238, 28, 81),
    Color(0xFFff758c),
  ];

  static List<Color> personalCardGradient = const [
    Color(0xFFff7443),
    Color.fromARGB(255, 239, 134, 96),
    Color.fromARGB(255, 239, 94, 41),
    Color.fromARGB(255, 235, 104, 57),
  ];

  static List<Color> farmCardGradient = const [
    Color(0xFF1ab0b0),
    Color.fromARGB(255, 25, 172, 172),
    Color.fromARGB(255, 45, 195, 195),
    Color.fromARGB(255, 32, 148, 148),
  ];

  static List<Color> footballCardGradient = const [
    Color(0xFF8676fe),
    Color.fromARGB(255, 98, 83, 211),
    Color.fromARGB(255, 120, 108, 213),
    Color.fromARGB(255, 117, 103, 223),
  ];

  //scaffold, appbarand logo
  static Color scaffoldBg = const Color.fromARGB(255, 241, 246, 255);
  static Color appBarBg = const Color.fromARGB(255, 241, 246, 255);

  //for availablitiy
  static Color greenShade3 = Colors.green.shade300;
  static Color redShade3 = Colors.red.shade300;
}