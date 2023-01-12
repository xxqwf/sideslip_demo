import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sideslip_demo/pages/sideslip/sideslip_animation_widget.dart';

class CustomSideslipPainter extends CustomPainter {
  final Offset indexPoint;
  final SideslipAlign? align;

  CustomSideslipPainter(this.indexPoint, this.align);

  @override
  void paint(Canvas canvas, Size size) {
    if (align == null) return;
    final paint = Paint();
    paint.color = Colors.black26;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;
    final path = Path();
    if (indexPoint == const Offset(0, 0)) return;
    final double halfHeight = size.height * 0.5;
    // todo 三阶贝塞尔曲线 ...

    Offset startOffset;
    Offset endOffset;
    Offset centerOffset;
    double indexPointX = indexPoint.dx;
    double indexPointY = indexPoint.dy;

    Offset offset1 = const Offset(0, 0);
    Offset offset2 = Offset(indexPointX * 1, indexPointY - halfHeight * 0.156);
    Offset offset3 = indexPoint;
    Offset offset4 = const Offset(0, 0);
    Offset offset5 = Offset(indexPointX * 1, indexPointY + halfHeight * 0.18);
    switch (align!) {
      case SideslipAlign.left:
        path.moveTo(0, 0);
        startOffset = const Offset(0, 0);
        endOffset = Offset(0, size.height);
        centerOffset = Offset(0, indexPointY);
        offset1 = Offset(indexPointX * 0.064, indexPointY - halfHeight * 0.24);
        offset4 = Offset(indexPointX * 0.135, indexPointY + halfHeight * 0.127);
        break;
      case SideslipAlign.top:
        path.moveTo(0, 0);
        startOffset = const Offset(0, 0);
        endOffset = Offset(0, size.width);
        centerOffset = Offset(indexPointX, 0);
        break;
      case SideslipAlign.right:
        path.moveTo(size.width, 0);
        startOffset = Offset(size.width, 0);
        endOffset = Offset(size.width, size.height);
        centerOffset = Offset(size.width, indexPointY);
        offset1 = Offset(size.width - (size.width - indexPointX) * 0.064,
            indexPointY - halfHeight * 0.24);
        offset4 = Offset(size.width - (size.width - indexPointX) * 0.135,
            indexPointY + halfHeight * 0.127);
        break;
      case SideslipAlign.bottom:
        path.moveTo(0, size.height);
        startOffset = Offset(0, size.height);
        endOffset = Offset(size.width, size.height);
        centerOffset = Offset(indexPointX, size.height);
        break;
    }
    path.cubicTo(
        offset1.dx, offset1.dy, offset2.dx, offset2.dy, offset3.dx, offset3.dy);

    path.lineTo(centerOffset.dx, centerOffset.dy);
    path.lineTo(startOffset.dx, startOffset.dy);
    path.moveTo(endOffset.dx, endOffset.dy);
    path.cubicTo(
        offset4.dx, offset4.dy, offset5.dx, offset5.dy, offset3.dx, offset3.dy);
    path.lineTo(centerOffset.dx, centerOffset.dy);
    path.lineTo(endOffset.dx, endOffset.dy);

    canvas.drawPath(path, paint);

    // Paint paint2 = Paint();
    // paint2.strokeWidth = 5;
    // paint2.color = Colors.orange;
    // canvas.drawPoints(PointMode.points, [offset1], paint2);
    // paint2.color = Colors.cyanAccent;
    // canvas.drawPoints(PointMode.points, [offset2], paint2);
    // paint2.color = Colors.red;
    // canvas.drawPoints(PointMode.points, [indexPoint], paint2);
    // paint2.color = Colors.green;
    // canvas.drawPoints(PointMode.points, [offset4], paint2);
    // paint2.color = Colors.blue;
    // canvas.drawPoints(PointMode.points, [offset5], paint2);
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
