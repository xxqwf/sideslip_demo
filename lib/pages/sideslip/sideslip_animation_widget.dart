import 'package:flutter/material.dart';

import 'sideslip_paint.dart';

class SideslipAnimationWidget extends StatefulWidget {
  final Widget? child;
  final double gestureWidth;

  const SideslipAnimationWidget({Key? key, this.child, this.gestureWidth = 20})
      : super(key: key);

  @override
  State<SideslipAnimationWidget> createState() =>
      _SideslipAnimationWidgetState();
}

class _SideslipAnimationWidgetState extends State<SideslipAnimationWidget> {
  SideslipAlign? _sideSlideAlign;
  final ValueNotifier<Offset> _slideNotifier =
      ValueNotifier(const Offset(0, 0));
  final ValueNotifier<bool> _leftGesture = ValueNotifier(false);
  final ValueNotifier<bool> _rightGesture = ValueNotifier(false);
  Offset? localToGlobalOffset;

  @override
  Widget build(BuildContext context) {
    return sideslipWidget();
  }

  Widget sideslipWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        ValueListenableBuilder(
          valueListenable: _slideNotifier,
          builder: (BuildContext context, Offset value, Widget? child) {
            return CustomPaint(
              foregroundPainter: CustomSideslipPainter(value, _sideSlideAlign),
              child: child ?? const SizedBox(),
            );
          },
          child: widget.child,
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: widget.gestureWidth,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: _leftGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideslipAlign.left;
                    onHorizontalDragDown(details);
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: widget.gestureWidth,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: widget.gestureWidth,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _rightGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideslipAlign.right;
                    onHorizontalDragDown(details);
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: widget.gestureWidth,
                    // child: contentWidget(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  onHorizontalDragDown(DragDownDetails details) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    localToGlobalOffset = renderBox?.localToGlobal(const Offset(0, 0));
    ignoreGesture();
  }

  onHorizontalDragUpdate(DragUpdateDetails details) {
    if (localToGlobalOffset != null) {
      _slideNotifier.value = details.globalPosition - localToGlobalOffset!;
    }
  }

  onHorizontalDragEnd(DragEndDetails details) {
    _slideNotifier.value = const Offset(0, 0);
    _sideSlideAlign = null;
    ignoreGesture();
  }

  ignoreGesture() {
    _leftGesture.value =
        _sideSlideAlign != null && _sideSlideAlign != SideslipAlign.left;
    _rightGesture.value =
        _sideSlideAlign != null && _sideSlideAlign != SideslipAlign.right;
  }
}

enum SideslipAlign { left, top, right, bottom }
