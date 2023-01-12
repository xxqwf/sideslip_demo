import 'package:flutter/material.dart';

import 'sideslip_paint.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  SideSlideAlign? _sideSlideAlign;
  final ValueNotifier<Offset> _slideNotifier =
      ValueNotifier(const Offset(0, 0));
  final ValueNotifier<bool> _leftGesture = ValueNotifier(false);
  final ValueNotifier<bool> _rightGesture = ValueNotifier(false);

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
    return Stack(
      fit: StackFit.expand,
      children: [
        ValueListenableBuilder(
          valueListenable: _slideNotifier,
          builder: (BuildContext context, Offset value, Widget? child) {
            return CustomPaint(
              foregroundPainter: CustomSideslipPainter(value, _sideSlideAlign),
              child: child!,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$count'),
              TextButton(
                onPressed: () {
                  count++;
                  refresh();
                },
                child: const SizedBox(
                    height: 40,
                    width: 100,
                    child: Card(child: Center(child: Text('click')))),
              )
            ],
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: 20,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: _leftGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideSlideAlign.left;
                    ignoreGesture();
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: 20,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: 20,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _rightGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideSlideAlign.right;
                    ignoreGesture();
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: 20,
                    // child: contentWidget(),
                  ),
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _slideNotifier,
          builder: (BuildContext context, Offset value, Widget? child) {
            return CustomPaint(
              foregroundPainter: CustomSideslipPainter(value, _sideSlideAlign),
              child: child!,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$count'),
              TextButton(
                onPressed: () {
                  count++;
                  refresh();
                },
                child: const SizedBox(
                    height: 40,
                    width: 100,
                    child: Card(child: Center(child: Text('click')))),
              )
            ],
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: 20,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: _leftGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideSlideAlign.left;
                    ignoreGesture();
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: 20,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: 20,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _rightGesture,
            builder: (BuildContext context, bool value, Widget? child) {
              return IgnorePointer(
                ignoring: value,
                child: GestureDetector(
                  onHorizontalDragDown: (DragDownDetails details) {
                    _sideSlideAlign = SideSlideAlign.right;
                    ignoreGesture();
                  },
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: 20,
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

  onHorizontalDragUpdate(DragUpdateDetails details) {
    _slideNotifier.value = details.globalPosition;
  }

  onHorizontalDragEnd(DragEndDetails details) {
    _slideNotifier.value = const Offset(0, 0);
    _sideSlideAlign = null;
    ignoreGesture();
  }

  ignoreGesture() {
    _leftGesture.value =
        _sideSlideAlign != null && _sideSlideAlign != SideSlideAlign.left;
    _rightGesture.value =
        _sideSlideAlign != null && _sideSlideAlign != SideSlideAlign.right;
  }

  refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}

enum SideSlideAlign { left, top, right, bottom }
