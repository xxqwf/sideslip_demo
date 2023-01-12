import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSideslipPainter2 extends CustomPainter {
  final Offset indexPoint;
  final Offset point1;
  final Offset point2;
  final Offset point3;
  final Offset point4;

  CustomSideslipPainter2(
      this.indexPoint, this.point1, this.point2, this.point3, this.point4);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black26;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    final path = Path();
    final halfWidth = size.width * 0.5;
    final halfHeight = size.height * 0.5;
    // todo 三阶贝塞尔曲线 ...
    Offset offset1 = point1;
    Offset offset2 = point2;
    Offset offset3 = indexPoint;
    path.cubicTo(
        offset1.dx, offset1.dy, offset2.dx, offset2.dy, offset3.dx, offset3.dy);
    Offset endOffset = Offset(0, size.height);
    path.moveTo(endOffset.dx, endOffset.dy);
    Offset offset4 = point3;
    Offset offset5 = point4;
    path.cubicTo(
        offset4.dx, offset4.dy, offset5.dx, offset5.dy, offset3.dx, offset3.dy);

    canvas.drawPath(path, paint);

    Paint paint2 = Paint();
    paint2.color = Colors.orange;
    paint2.strokeWidth = 5;
    paint2.style = PaintingStyle.stroke;
    print('================: new point: ${[
      point1,
      point2,
      point3,
      point4,
      indexPoint
    ]}');
    canvas.drawPoints(PointMode.points,
        [offset1, offset2, endOffset, offset4, offset5, indexPoint], paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Offset computeBezierOffset(
      double t, Offset offset0, Offset offset1, Offset offset2) {
    double x = pow(1 - t, 2) * offset0.dx +
        2 * t * (1 - t) * offset1.dx +
        pow(t, 2) * offset2.dx;
    double y = pow(1 - t, 2) * offset0.dy +
        2 * t * (1 - t) * offset1.dy +
        pow(t, 2) * offset2.dy;
    return Offset(x, y);
  }
}
