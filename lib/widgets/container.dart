
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
    return Stack(
      children: [
        child ?? const SizedBox.expand(),
        // stack,
        CustomPaint(
          painter: _GradieContainerPainter(
            gradie: gradie,
            borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
          child: const SizedBox.expand(),
        ),
      ],
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
