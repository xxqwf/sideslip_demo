import 'package:flutter/material.dart';
import 'package:sideslip_demo/pages/sideslip_paint2.dart';

class BezierMovePointer extends StatefulWidget {
  const BezierMovePointer({Key? key}) : super(key: key);

  @override
  State<BezierMovePointer> createState() => _BezierMovePointerState();
}

class _BezierMovePointerState extends State<BezierMovePointer> {
  Size? currentSize;
  Rect _rect = Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
  Offset currentPoint = const Offset(200, 200);
  PointType currentType = PointType.point1;

  Offset point1 = const Offset(50, 357.0);
  Offset point2 = const Offset(188.0, 376.0);
  Offset point3 = const Offset(50, 568.0);
  Offset point4 = const Offset(176.0, 552.0);
  Offset point5 = const Offset(194.0, 478.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: sideslipWidget(),
      ),
    );
  }

  Widget sideslipWidget() {
    return GestureDetector(
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Image.asset('images/back2.PNG', fit: BoxFit.fitHeight)),
          CustomPaint(
            painter: CustomSideslipPainter2(
                currentPoint, point1, point2, point3, point4),
          ),
        ],
      ),
    );
  }

  Widget contentWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  onHorizontalDragDown(DragDownDetails details) {
    print('=========gesture down: ${details.localPosition}');
    Rect rect1 = Rect.fromCenter(center: point1, width: 40, height: 40);
    if (rect1.contains(details.localPosition)) {
      currentType = PointType.point1;
      return;
    }
    Rect rect2 = Rect.fromCenter(center: point2, width: 40, height: 40);
    if (rect2.contains(details.localPosition)) {
      currentType = PointType.point2;
      return;
    }
    Rect rect3 = Rect.fromCenter(center: point3, width: 40, height: 40);
    if (rect3.contains(details.localPosition)) {
      currentType = PointType.point3;
      return;
    }
    Rect rect4 = Rect.fromCenter(center: point4, width: 40, height: 40);
    if (rect4.contains(details.localPosition)) {
      currentType = PointType.point4;
      return;
    }
    _rect = Rect.fromCenter(center: currentPoint, width: 40, height: 40);
    if (_rect.contains(details.localPosition)) {
      currentType = PointType.indexPoint;
      return;
    }
  }

  onHorizontalDragStart(DragStartDetails details) {
    print('=========gesture start: ${details.localPosition}');
  }

  onHorizontalDragUpdate(DragUpdateDetails details) {
    print('=========gesture: update ${details.localPosition}');
    // currentPoint = details.localPosition;
    // translate(currentPoint);

    switch (currentType) {
      case PointType.point1:
        point1 = details.localPosition;
        refresh();
        break;
      case PointType.point2:
        point2 = details.localPosition;
        refresh();
        break;
      case PointType.point3:
        point3 = details.localPosition;
        refresh();
        break;
      case PointType.point4:
        point4 = details.localPosition;
        refresh();
        break;
      case PointType.indexPoint:
        currentPoint = details.localPosition;
        refresh();
        break;
    }
  }

  onHorizontalDragEnd(DragEndDetails details) {
    print('=========gesture: end');
  }

  onHorizontalDragCancel() {
    print('=========gesture: cancel');
  }

  translate(Offset offset) {
    if (currentSize == null) return;
    // _rect = Rect.fromCenter(center: offset, width: 40, height: 40);
    refresh();
  }

  refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  logcat(dynamic value) {
    print('=========size: $value');
  }
}

enum PointType {
  point1,
  point2,
  point3,
  point4,
  indexPoint,
}
