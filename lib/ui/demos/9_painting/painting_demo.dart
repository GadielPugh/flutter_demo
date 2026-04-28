import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintingDemo extends StatefulWidget {
  const PaintingDemo({super.key});

  @override
  State<PaintingDemo> createState() => _PaintingDemoState();
}

class _PaintingDemoState extends State<PaintingDemo> {
  // define the variables
  double x1 = 30;
  double y1 = 150;
  double x2 = 270;
  double y2 = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      // body: Center(
      //   child: Container(
      //     // color: Colors.cyan,
      //     child: ProgressBar(
      //       barColor: Colors.blue,
      //       thumbColor: Colors.red,
      //       thumbSize: 20.0,
      //     ),
      //   ),
      // ),
      //  body: Center(
        
      //   child: Container(
          
      //     decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      //     child: CustomPaint(size: Size(300, 300), painter: MyPainter()),
      //   ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("X1"),
          ProgressBar(
            barColor: Colors.blue,
            thumbColor: Colors.red,
            value: x1 / 300,
            onChanged: (v) => setState(() => x1 = v * 300),
          ),
          Text("Y1"),
          ProgressBar(
            barColor: Colors.blue,
            thumbColor: Colors.red,
            value: y1 / 300,
            onChanged: (v) => setState(() => y1 = v * 300),
          ),
          Text("X2"),
          ProgressBar(
            barColor: Colors.blue,
            thumbColor: Colors.red,
            value: x2 / 300,
            onChanged: (v) => setState(() => x2 = v * 300),
          ),
          Text("Y2"),
          ProgressBar(
            barColor: Colors.blue,
            thumbColor: Colors.red,
            value: y2 / 300,
            onChanged: (v) => setState(() => y2 = v * 300),
          ),
          
          const SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(x1: x1, y1: y1, x2: x2, y2: y2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  // definre the variables to update the canva line
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  MyPainter({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(50, 50)
      // ..lineTo(200, 200)
      // ..quadraticBezierTo(30, 150, 150, 100)
      // ..quadraticBezierTo(270, 50, 240, 150);
      // ..cubicTo(30, 150, 270, 50, 240, 150);
      ..cubicTo(x1, y1, x2, y2, 250, 250);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return x1 != oldDelegate.x1 ||
        y1 != oldDelegate.y1 ||
        x2 != oldDelegate.x2 ||
        y2 != oldDelegate.y2;
  }
}

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    super.key,
    required this.barColor,
    required this.thumbColor,
    required this.value,
    required this.onChanged,
    this.thumbSize = 20.0,
  });

  final Color barColor;
  final Color thumbColor;
  final double value;
  final ValueChanged<double> onChanged;
  final double thumbSize;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      thumbColor: thumbColor,
      value: value,
      onChanged: onChanged,
      thumbSize: thumbSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderProgressBar renderObject,
  ) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..value = value
      ..onChanged = onChanged
      ..thumbSize = thumbSize;
  }
}

class RenderProgressBar extends RenderBox {
  RenderProgressBar({
    required Color barColor,
    required Color thumbColor,
    required double value,
    required ValueChanged<double> onChanged,
    required double thumbSize,
  }) : _barColor = barColor,
       _thumbColor = thumbColor,
       _value = value,
       _onChanged = onChanged,
       _thumbSize = thumbSize {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (details) {
        _updateThumbPosition(details.localPosition);
      };
  }

  void _updateThumbPosition(Offset localPosition) {
    final dx = localPosition.dx.clamp(0, size.width);
    _value = dx / size.width;
    _onChanged(_value);
    markNeedsPaint();
  }

  Color _barColor;
  Color get barColor => _barColor;
  set barColor(Color value) {
    _barColor = value;
    markNeedsPaint();
  }

  Color _thumbColor;
  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    _thumbColor = value;
    markNeedsPaint();
  }

  double _value;
  double get value => _value;
  set value(double v) {
    _value = v;
    markNeedsPaint();
  }

  ValueChanged<double> _onChanged;
  set onChanged(ValueChanged<double> value) {
    _onChanged = value;
  }

  double _thumbSize;
  double get thumbSize => _thumbSize;
  set thumbSize(double value) {
    _thumbSize = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = constraints.constrain(Size(constraints.maxWidth, thumbSize));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 5;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      barPaint,
    );

    final thumbPaint = Paint()..color = thumbColor;
    canvas.drawCircle(
      Offset(value * size.width, size.height / 2),
      thumbSize / 2,
      thumbPaint,
    );
    canvas.restore();
  }

  late HorizontalDragGestureRecognizer _drag;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }
}
