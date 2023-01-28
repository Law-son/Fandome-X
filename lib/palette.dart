//palette.dart
import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor kToDark =  MaterialColor( 
    0x181a20, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
     <int, Color>{ 
      50: Color.fromRGBO(24, 26, 32, 0.1),
      100: Color.fromRGBO(24, 26, 32, 0.2),
      200: Color.fromRGBO(24, 26, 32, 0.3),
      300: Color.fromRGBO(24, 26, 32, 0.4),
      400: Color.fromRGBO(24, 26, 32, 0.5), 
      500: Color.fromRGBO(24, 26, 32, 0.6),
      600: Color.fromRGBO(24, 26, 32, 0.7),
      700: Color.fromRGBO(24, 26, 32, 0.8),
      800: Color.fromRGBO(24, 26, 32, 0.9),
      900: Color.fromRGBO(24, 26, 32, 1),
    }, 
  ); 
}
      