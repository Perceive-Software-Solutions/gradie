library gradie;

import 'package:flutter/material.dart';

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