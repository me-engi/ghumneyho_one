import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightToLeftCurve extends StatelessWidget {
  final Color color;

  const RightToLeftCurve({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: RightToLeftCurvePainterNotDotted(color: color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: RightToLeftCurvePainter(color: color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 19.0),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: RightToLeftCurvePainterNotDotted(color: color),
            ),
          ),
        ),
      ],
    );
  }
}

class RightToLeftCurvePainter extends CustomPainter {
  final Color color;

  RightToLeftCurvePainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..cubicTo(
        size.width / 7,
        -size.height / 4,
        3 * size.width / 4,
        5 * size.height / 9,
        size.width,
        -size.height / 4.2,
      );

    const dashWidth = 5; // Width of each dash
    const dashSpace = 5; // Space between dashes

    final pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LefttoRightCurve extends StatelessWidget {
  final Color color;

  const LefttoRightCurve({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: LefttoRightCurvePainterNotedDotted(color: color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: LefttoRightCurvePainter(color: color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 19.0),
          child: SizedBox(
            width: 1500.w, // Adjust the width as needed
            height: size ? 180 : 380, // Adjust the height as needed
            child: CustomPaint(
              painter: LefttoRightCurvePainterNotedDotted(color: color),
            ),
          ),
        ),
      ],
    );
  }
}

class LefttoRightCurvePainter extends CustomPainter {
  final Color color;

  LefttoRightCurvePainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, -size.height / 5)
      ..cubicTo(
        size.width / 7,
        5 * size.height / 9,
        3 * size.width / 4,
        -size.height / 4,
        size.width,
        size.height / 1.85,
      );

    const dashWidth = 5; // Width of each dash
    const dashSpace = 5; // Space between dashes

    final pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RightToLeftCurvePainterNotDotted extends CustomPainter {
  final Color color;

  RightToLeftCurvePainterNotDotted({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..cubicTo(
        size.width / 7,
        -size.height / 4,
        3 * size.width / 4,
        5 * size.height / 9,
        size.width,
        -size.height / 4,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Assuming the curve doesn't change, so no need to repaint
  }
}

class LefttoRightCurvePainterNotedDotted extends CustomPainter {
  final Color color;

  LefttoRightCurvePainterNotedDotted({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, -size.height / 5)
      ..cubicTo(
        size.width / 7,
        5 * size.height / 9,
        3 * size.width / 4,
        -size.height / 4,
        size.width,
        size.height / 1.8,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
