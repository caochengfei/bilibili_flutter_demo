//高斯模糊

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/rpx.dart';

class HiBlur extends StatelessWidget {
  final Widget? child;
  // 模糊值
  final double sigma;
  const HiBlur({Key? key, this.child, this.sigma = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.white10,
        child: child,
      ),
    );
  }
}
