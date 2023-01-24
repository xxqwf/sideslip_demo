import 'package:flutter/material.dart';
import 'package:sideslip_demo/pages/sideslip/sideslip_animation_widget.dart';

class MyHomeWidget extends StatefulWidget {
  const MyHomeWidget({Key? key}) : super(key: key);

  @override
  State<MyHomeWidget> createState() => _MyHomeWidgetState();
}

class _MyHomeWidgetState extends State<MyHomeWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nihao'),
        centerTitle: true,
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SideslipAnimationWidget(
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
      ),
    );
  }

  refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
