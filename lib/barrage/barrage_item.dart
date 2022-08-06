import 'package:bilibili_demo/barrage/barrage_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged onComplete;
  final Duration duration;
  var _key = GlobalKey<BarrageTransitionState>();
  BarrageItem(
      {Key? key,
      required this.id,
      required this.top,
      required this.child,
      required this.onComplete,
      this.duration = const Duration(milliseconds: 9000)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
          key: _key,
          child: child,
          onComplete: (v) {
            onComplete(id);
          },
          duration: duration,
        ));
  }
}
