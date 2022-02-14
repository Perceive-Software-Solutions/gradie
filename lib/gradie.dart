library gradie;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:gradie/process_border.dart';
import 'package:gradie/smooth_path.dart';

part 'widgets/container.dart';
part 'widgets/border.dart';

///A combined gradient
class Gradie{

  final List<Gradient> gradients;
  final Color? surface;

  Gradie({required this.gradients, this.surface});

  @override
  bool operator ==(Object other) {
    if(other is Gradie){
      return gradients.length == other.gradients.length &&
        surface == other.surface &&
        gradients == other.gradients;
    }
    return false;
  }

  @override
  int get hashCode => gradients.fold<int>(0, (previousValue, element) => previousValue + element.hashCode);


}

//Extension to turn a gradient into a gradie
extension GradieGradient on Gradient {

  Gradie get gradie{
    return Gradie(
      gradients: [this],
      surface: null
    );
  }

}