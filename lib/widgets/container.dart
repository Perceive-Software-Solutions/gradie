
part of '../gradie.dart';

class GradieContainer extends StatelessWidget {

  ///Child of the card
  final Widget? child;

  ///Defaulted to surface
  final Gradie gradie;

  //Container proxies
  final BorderRadius? borderRadius;

  
  const GradieContainer({
    Key? key,
    this.child,
    required this.gradie, 
    this.borderRadius, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Returns the combo stack
    return ClipPath(
      clipper: _ClipSmoothPath(borderRadius: borderRadius ?? SmoothBorderRadius.zero),
      child: CustomPaint(
        painter: _GradieContainerPainter(
          gradie: gradie,
          borderRadius: borderRadius ?? SmoothBorderRadius.zero
        ),
        child: child,
      ),
    );
  }
}

class _GradieContainerPainter extends CustomPainter {

  final Gradie gradie;
  final BorderRadius borderRadius;

  _GradieContainerPainter({required this.gradie, this.borderRadius = BorderRadius.zero});

  @override
  void paint(Canvas canvas, Size size) {
    
    RRect card = borderRadius.toRRect(Offset.zero & size);

    if(gradie.surface != null){
      Paint backgroundPaint = Paint()
        ..color = gradie.surface!;

      canvas.drawRRect(card, backgroundPaint);
    }

    for (var gradient in gradie.gradients) {
      Paint paint = Paint()
        ..shader = gradient.createShader(card.outerRect);
      
      canvas.drawRRect(card, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if(oldDelegate is _GradieBorderPainter){
      return gradie != oldDelegate.gradie;
    }
    return false;
  }

}

class _ClipSmoothPath extends CustomClipper<Path> {

  final BorderRadius borderRadius;

  _ClipSmoothPath({this.borderRadius = BorderRadius.zero});
  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final outerPath = getOuterPath(
      rect,
      borderRadius,
      0.6,
      textDirection: TextDirection.ltr,
    );
    return outerPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if(oldClipper is _ClipSmoothPath){
      return oldClipper != this;
    }
    return false;
  }
  
}