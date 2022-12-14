//弹幕移动特效
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;
  const BarrageTransition(
      {Key? key,
      required this.child,
      required this.duration,
      required this.onComplete})
      : super(key: key);

  @override
  State<BarrageTransition> createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //创建动画控制器
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addStatusListener((status) {
            // 动画执行完毕的回调
            if (status == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });
    // 定义从右到左的动画
    var begin = Offset(1.0, 0);
    var end = Offset(-1, 0);
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
