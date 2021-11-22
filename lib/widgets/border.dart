part of '../gradie.dart';

class GradieBorder extends StatelessWidget {

  ///Child of the card
  final Widget? child;

  ///Defaulted to surface
  final Gradie gradie;

  ///Background color
  final Color? background;

  //Drop shadows
  final List<BoxShadow>? boxShadow;

  //Container proxies
  final BorderRadius? borderRadius;

  
  const GradieBorder({
    Key? key,
    this.child,
    required this.gradie, 
    this.borderRadius, 
    this.background, 
    this.boxShadow, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Returns the graide stack
    return Stack(
      children: [

        //background container
        Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: background,
            boxShadow: boxShadow
          ),
          child: const SizedBox.expand()
        ),

        // border gradie
        CustomPaint(
          painter: _GradieBorderPainter(
            gradie: gradie,
            borderRadius: borderRadius ?? BorderRadius.circular(0),
          ),
          child: const SizedBox.expand(),
        ),

        //Child
        if(child != null)
          Positioned.fill(child: child!)
      ],
    );
  }
}

class _GradieBorderPainter extends CustomPainter {

  final Gradie gradie;
  final BorderRadius borderRadius;

  _GradieBorderPainter({required this.gradie, this.borderRadius = BorderRadius.zero});

  @override
  void paint(Canvas canvas, Size size) {
    
    RRect card = borderRadius.toRRect(Offset.zero & size);

    for (var gradient in gradie.gradients) {
      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
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
