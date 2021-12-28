import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:gradie/gradie.dart';

class ElevatedCard extends StatelessWidget {

  ///Child of the card
  final Widget? child;

  ///Defaulted to surface
  final Color? color;

  ///Defaulted to true
  final bool reflective;

  //Container proxies
  final double? width;
  final BorderRadius? borderRadius;
  final BoxConstraints? constraints;

  
  const ElevatedCard({
    Key? key,
    this.child,
    this.color, 
    this.width = double.infinity, 
    this.borderRadius, 
    this.constraints, 
    this.reflective = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if(reflective == false){
      return Container(
        width: width,
        constraints: constraints,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color ?? Constants.surface,
          boxShadow: [
            BoxShadow(
              color: Constants.shadow.withOpacity(0.14),
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: Constants.shadow.withOpacity(0.12),
              blurRadius: 1,
              spreadRadius: -1,
              offset: Offset(2, 2),
            ),
            BoxShadow(
              color: Constants.shadow.withOpacity(0.20),
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: child,
      );
    }

    //New Card -> 1dp
    return Container(
      width: width,
      constraints: constraints,
      child: GradieBorder(
        gradie: Constants.reflection,
        borderRadius: borderRadius,
        background: color ?? Constants.surface,
        boxShadow: [
          BoxShadow(
            color: Constants.shadow.withOpacity(0.14),
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Constants.shadow.withOpacity(0.12),
            blurRadius: 1,
            spreadRadius: -1,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: Constants.shadow.withOpacity(0.20),
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        child: child,
      ),
    );
  }
}