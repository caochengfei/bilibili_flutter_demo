// 登录效果
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/rpx.dart';

class CFLoginEffect extends StatefulWidget {
  final bool protect;

  const CFLoginEffect({Key? key, this.protect = true}) : super(key: key);

  @override
  State<CFLoginEffect> createState() => _CFLoginEffectState();
}

class _CFLoginEffectState extends State<CFLoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.px),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            image: AssetImage("images/logo.png"),
            height: 90.px,
            width: 90.px,
          ),
          _image(false)
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect
        ? 'images/head_right_protect.png'
        : 'images/head_right.png';
    return Image(
      image: AssetImage(left ? headLeft : headRight),
      height: 90.px,
    );
  }
}
