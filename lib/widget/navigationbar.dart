import 'package:bilibili_demo/provider/theme_provider.dart';
import 'package:bilibili_demo/util/color.dart';
import 'package:bilibili_demo/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:provider/provider.dart';
import '../util/rpx.dart';

enum StatusStyle { LIGHT, DARK }

class CFNavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const CFNavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<CFNavigationBar> {
  var _statusStyle = StatusStyle.LIGHT;
  var _color;

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }

    _statusBarInit();

    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: _color,
      ),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
