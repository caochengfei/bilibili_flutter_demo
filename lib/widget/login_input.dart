import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../util/rpx.dart';

class LoginInput extends StatefulWidget {
  final String? title;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keyboardType;

  const LoginInput(
      {this.title,
      this.hint,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super();

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.px),
              width: 100,
              child:
                  Text(widget.title ?? "", style: TextStyle(fontSize: 16.px)),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15.px : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20.px, right: 20.px),
          border: InputBorder.none,
          hintText: widget.hint ?? "",
          hintStyle: TextStyle(fontSize: 15.px, color: Colors.grey)),
    ));
  }
}
