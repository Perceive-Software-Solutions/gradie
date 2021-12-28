import 'package:flutter/material.dart';
import 'package:gradie/gradie.dart';

class Constants {

  static Color surface = const Color(0xFFF7FAFD);
  static Color shadow = const Color(0xFF92ACC4);

  static Gradie reflection = Gradie(
    gradients: [
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0, 0.03125, 0.0625, 0.125, 0.25, 0.5, 1.0],
        colors: [
          const Color(0xFFFFFFFF), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0),
        ]
      ),
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0, 0.5, 1.0],
        colors: [
          const Color(0xFFFFFFFF), 
          const Color(0xFFFFFFFF).withOpacity(0), 
          const Color(0xFFFFFFFF).withOpacity(0),
        ]
      )
    ]
  );
}