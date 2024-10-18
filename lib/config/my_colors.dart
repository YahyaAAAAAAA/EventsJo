import 'package:flutter/material.dart';

class MyColors {
  //main bg color
  static Color beige = const Color(0xFFD9D3C8);

  //for buttons and exposed texts mostly
  static Color black = const Color(0xFF0B0B0B);

  //for stand alone buttons
  static Color gray = const Color(0xFF232323);

  //for stand alone buttons
  static Color gray2 = const Color.fromARGB(255, 128, 128, 128);

  //highlighted text when on black bg (used for price mostly)
  static Color lightYellow = const Color(0xFFFFF6CC);

  //scaffold and appbar
  static Color scaffoldBg = beige;
  static Color appBarBg = beige;

  //for availablitiy
  static Color green = Colors.green.shade300;
  static Color red = Colors.red.shade300;
}
