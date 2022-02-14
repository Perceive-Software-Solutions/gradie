part of '../gradie.dart';

class GradieBorder extends StatelessWidget {

  ///Child of the card
  final Widget? child;

  ///Defaulted to surface
  final Gradie gradie;

  final Decoration? decoration;

  //Container proxies
  final BorderRadius? borderRadius;

  // Smoothing radius
  final double? smoothingRadius;

  
  const GradieBorder({
    Key? key,
    this.child,
    required this.gradie,
    this.borderRadius,
    this.smoothingRadius, 
    this.decoration
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Returns the graide stack
    return Container(
      //background container
      decoration: decoration,
      // border gradie
      child: CustomPaint(
        painter: _GradieBorderPainter(
          gradie: gradie,
          smoothingRadius: smoothingRadius ?? 0.0,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        //Child
        child: child,
      ),
      // child: const SizedBox.expand()
    );
  }
}

/// Creates a [Path] inside the given [Rect].
  Path toPath(Rect rect, BorderRadius borderRadius, double smoothingRadius) {
    final width = rect.width;
    final height = rect.height;

    final result = Path();

    final topLeft = SmoothRadius(
      cornerRadius: borderRadius.topLeft.x,
      cornerSmoothing: smoothingRadius,
    );

    final bottomLeft = SmoothRadius(
      cornerRadius: borderRadius.bottomLeft.x,
      cornerSmoothing: smoothingRadius
    );

    final topRight = SmoothRadius(
      cornerRadius: borderRadius.topRight.x,
      cornerSmoothing: smoothingRadius
    );

    final bottomRight = SmoothRadius(
      cornerRadius: borderRadius.bottomRight.x,
      cornerSmoothing: smoothingRadius
    );

    /// Calculating only if values are different
    final processedTopLeft = ProccessedRadius(
      topLeft,
      width: width,
      height: height,
    );
    final processedBottomLeft = topLeft == bottomLeft
        ? processedTopLeft
        : ProccessedRadius(
            bottomLeft,
            width: width,
            height: height,
          );
    final processedBottomRight = bottomLeft == bottomRight
        ? processedBottomLeft
        : ProccessedRadius(
            bottomRight,
            width: width,
            height: height,
          );
    final processedTopRight = topRight == bottomRight
        ? processedBottomRight
        : ProccessedRadius(
            topRight,
            width: width,
            height: height,
          );

    result
      ..addSmoothTopRight(processedTopRight, rect)
      ..addSmoothBottomRight(processedBottomRight, rect)
      ..addSmoothBottomLeft(processedBottomLeft, rect)
      ..addSmoothTopLeft(processedTopLeft, rect);

    return result.transform(
      Matrix4.translationValues(rect.left, rect.top, 0).storage,
    );
  }

@override
  Path getOuterPath(Rect rect, BorderRadius borderRadius, double smoothingRadius, {TextDirection? textDirection}) {
    final outerRect = rect;
    final radius = borderRadius +
      SmoothBorderRadius.all(
        SmoothRadius(
          cornerRadius: BorderSide.none.width,
          cornerSmoothing: smoothingRadius,
        )
      );

    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => (x as SmoothRadius).cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(outerRect));
    }

    return toPath(outerRect, radius, smoothingRadius);
  }

class _GradieBorderPainter extends CustomPainter {

  final Gradie gradie;
  final BorderRadius borderRadius;
  final double smoothingRadius;

  _GradieBorderPainter({required this.gradie, this.borderRadius = BorderRadius.zero, this.smoothingRadius = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final outerPath = getOuterPath(
      rect,
      borderRadius,
      smoothingRadius,
      textDirection: TextDirection.ltr,
    );

    for (var gradient in gradie.gradients) {
      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..shader = gradient.createShader(rect);
      
      canvas.drawPath(outerPath, paint);
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
