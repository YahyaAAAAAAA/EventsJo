import 'package:flutter/material.dart';

class MyColors {
  //main bg color
  static Color gray = const Color(0xFF282e3c);

  //for buttons and exposed texts mostly
  static Color red = Colors.grey.shade300;

  //for stand alone buttons
  static Color white = const Color(0xFF363c54);

  //navigation bar
  static Color navBar = const Color(0xFF242936);

  //for rating
  static Color emptyRate = const Color(0xFF808080);
  static Color fullRate = Colors.yellow.shade700;

  //highlighted text when on red bg (used for price mostly)
  static Color black = Colors.grey.shade300;

  //main logo gradient
  static List<Color> logoList = [
    Colors.grey.shade200,
    Colors.grey.shade300,
    Colors.grey.shade400,
  ];

  //scaffold and appbar
  static Color scaffoldBg = gray;
  static Color appBarBg = gray;

  //for availablitiy
  static Color greenShade3 = Colors.green.shade300;
  static Color redShade3 = Colors.red.shade300;
}
