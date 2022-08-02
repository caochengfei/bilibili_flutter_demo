import 'package:bilibili_demo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HiTab extends StatelessWidget {
  const HiTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize,
      this.borderWidth = 3,
      this.insets = 15,
      this.unselectedLabelColor})
      : super(key: key);
  final List<Widget> tabs;
  final TabController? controller;
  final double? fontSize;
  final double borderWidth;
  final double insets;
  final Color? unselectedLabelColor;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: primary,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineTabIndicator(
            insets: EdgeInsets.only(left: insets, right: insets),
            borderSide: BorderSide(color: primary, width: borderWidth)),
        tabs: tabs);
  }
}
