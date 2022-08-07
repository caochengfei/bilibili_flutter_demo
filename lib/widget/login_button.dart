import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import '../util/color.dart';
import '../util/rpx.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key, this.title = "", this.enable = false, this.onPressed})
      : super(key: key);
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
        height: 45.px,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.px),
        ),
      ),
    );
  }
}
