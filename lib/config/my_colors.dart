import 'package:flutter/material.dart';

class MyColors {
  //main bg color
  static Color gray = Colors.grey.shade200;

  //for buttons and exposed texts mostly
  static Color red = const Color(0xFFE7492E);

  //for stand alone buttons
  static Color white = const Color(0xFFffffff);

  //for rating
  static Color emptyRate = const Color(0xFF808080);
  static Color fullRate = Colors.yellow.shade700;

  //highlighted text when on red bg (used for price mostly)
  static Color black = const Color.fromARGB(255, 24, 24, 24);

  //main logo gradient
  static List<Color> logoList = [
    const Color(0xFF000000),
    const Color.fromARGB(255, 44, 44, 44),
    const Color(0xFF434343),
    const Color(0xFF757575),
  ];

  //scaffold and appbar
  static Color scaffoldBg = gray;
  static Color appBarBg = gray;

  //for availablitiy
  static Color greenShade3 = Colors.green.shade300;
  static Color redShade3 = Colors.red.shade300;
}
